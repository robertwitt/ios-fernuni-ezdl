//
//  PersonalLibraryViewController.m
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryViewController.h"
#import "ServiceFactory.h"


@interface PersonalLibraryViewController () <PersonalLibraryGroupsViewControllerDelegate, DocumentDetailViewControllerDelegate>

@property (nonatomic, strong) UIPopoverController *groupsPopover;
@property (nonatomic, weak, readonly) id<PersonalLibraryService> personalLibraryService;
@property (nonatomic, strong) NSMutableArray *displayedGroups;
@property (nonatomic) NSInteger sectionOfGroupToDelete;
@property (nonatomic, weak, readonly) NSArray *allDocuments;

- (IBAction)openGroups:(UIBarButtonItem *)sender;
- (PersonalLibraryGroup *)groupInSection:(NSInteger)section;
- (PersonalLibraryReference *)referenceAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)detailTextForReference:(PersonalLibraryReference *)reference;
- (void)askToDeleteGroupInSection:(NSInteger)section;
- (void)prepareForGroupsSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForDocumentDetailSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end


@implementation PersonalLibraryViewController

static NSString *SegueIdentifierGroups = @"GroupsSegue";
static NSString *SegueIdentifierDocumentDetail = @"DocumentDetailSegue";

@synthesize groupsPopover = _groupsPopover;
@synthesize personalLibraryService = _personalLibraryService;
@synthesize displayedGroups = _displayedGroups;
@synthesize sectionOfGroupToDelete = _sectionOfGroupToDelete;

#pragma mark Managing the View

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    self.groupsPopover = nil;
    _personalLibraryService = nil;
    self.displayedGroups = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // In self.displayedGroups those groups are collected that shall be displayed
    if (!self.displayedGroups.notEmpty) self.displayedGroups = [NSMutableArray arrayWithArray:[self.personalLibraryService personalLibraryGroups]];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.groupsPopover dismissPopoverAnimated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (id<PersonalLibraryService>)personalLibraryService {
    if (!_personalLibraryService) _personalLibraryService = [[ServiceFactory sharedFactory] personalLibraryService];
    return _personalLibraryService;
}

- (NSMutableArray *)displayedGroups {
    if (!_displayedGroups) _displayedGroups = [NSMutableArray array];
    return _displayedGroups;
}

- (PersonalLibraryGroup *)groupInSection:(NSInteger)section {
    return [self.displayedGroups objectAtIndex:section];
}

- (PersonalLibraryReference *)referenceAtIndexPath:(NSIndexPath *)indexPath {
    PersonalLibraryGroup *group = [self groupInSection:indexPath.section];
    NSArray *references = [group.references allObjects];
    return [references objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.displayedGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self groupInSection:section].references.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReferenceCell"];
    
    PersonalLibraryReference *reference = [self referenceAtIndexPath:indexPath];
    cell.textLabel.text = reference.document.title;
    cell.detailTextLabel.text = [self detailTextForReference:reference];
    
    return cell;
}

- (NSString *)detailTextForReference:(PersonalLibraryReference *)reference {
    NSMutableString *string = [NSMutableString string];
    NSArray *array = [reference.document.authors allObjects];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Author *author = obj;
        if (idx == 0) [string appendString:author.fullName];
        else [string appendFormat:@"; %@", author.fullName];
    }];
    
    [string appendFormat:@" (%@)", reference.document.year];
    
    return string;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self groupInSection:section].name;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SegueIdentifierGroups]) {
        [self prepareForGroupsSegue:segue sender:sender];
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierDocumentDetail]) {
        [self prepareForDocumentDetailSegue:segue sender:sender];
    }
}

#pragma mark Deleting of References and Groups

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.personalLibraryService deleteReference:[self referenceAtIndexPath:indexPath]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self askToDeleteGroupInSection:indexPath.section];
    }
}

- (void)askToDeleteGroupInSection:(NSInteger)section {
    PersonalLibraryGroup *group = [self groupInSection:section];
    if (group.references.count == 0) {
        // All references have been removed from the group. Ask the user whether or not he wants to delete the entire group.
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"Empty Group Message", nil), group.name];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Empty Group", nil)
                                                            message:message
                                                           delegate:self 
                                                  cancelButtonTitle:NSLocalizedString(@"No", nil)
                                                  otherButtonTitles:NSLocalizedString(@"Yes", nil), nil];
        [alertView show];
        
        // Store group's section here in a property to have access in alert view delegation method
        self.sectionOfGroupToDelete = section;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // Yes button clicked, delete the group in self.groupToDelete
        PersonalLibraryGroup *group = [self groupInSection:self.sectionOfGroupToDelete];
        [self.personalLibraryService deleteGroup:group];
        [self.displayedGroups removeObject:group];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:self.sectionOfGroupToDelete]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark Move References to other Groups

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section != destinationIndexPath.section) {
        // Moved reference to new group
        [self.personalLibraryService moveReference:[self referenceAtIndexPath:sourceIndexPath]
                                           toGroup:[self groupInSection:destinationIndexPath.section]];
        
        [self askToDeleteGroupInSection:sourceIndexPath.section];
    }
}

#pragma mark Popover to Control Displayed Groups

- (IBAction)openGroups:(UIBarButtonItem *)sender {
    if (self.groupsPopover.popoverVisible) [self.groupsPopover dismissPopoverAnimated:YES];
    else [self performSegueWithIdentifier:SegueIdentifierGroups sender:sender];
}

- (void)prepareForGroupsSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PersonalLibraryGroupsViewController *viewController = (PersonalLibraryGroupsViewController *)((UINavigationController *)segue.destinationViewController).topViewController;
    viewController.displayedGroups = self.displayedGroups;
    viewController.delegate = self;
    
    self.groupsPopover = ((UIStoryboardPopoverSegue *)segue).popoverController;
}

- (void)groupsViewController:(PersonalLibraryGroupsViewController *)viewController didChangeGroupSelection:(NSArray *)groups {
    self.displayedGroups = [NSMutableArray arrayWithArray:groups];
    [self.tableView reloadData];
}

#pragma mark Displaying the Document in the Reference

- (void)prepareForDocumentDetailSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DocumentDetailViewController *viewController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
    viewController.displayedDocument = [self referenceAtIndexPath:indexPath].document;
    viewController.hideAddReferenceItem = YES;
    viewController.delegate = self;
}

- (NSInteger)documentDetailViewControllerNumberOfDocuments:(DocumentDetailViewController *)viewController {
    return self.allDocuments.count;
}

- (NSInteger)documentDetailViewController:(DocumentDetailViewController *)viewController indexOfDocument:(Document *)document {
    return [self.allDocuments indexOfObject:document];
}

- (Document *)documentDetailViewController:(DocumentDetailViewController *)viewController documentAtIndex:(NSInteger)index {
    return [self.allDocuments objectAtIndex:index];
}

- (NSArray *)allDocuments {
    NSMutableArray *allDocuments = [NSMutableArray array];
    
    [self.displayedGroups enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PersonalLibraryGroup *group = obj;
        [group.references enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            PersonalLibraryReference *reference = obj;
            [allDocuments addObject:reference.document];
        }];
    }];
    
    return allDocuments;
}

@end
