//
//  PersonalLibraryGroupsViewController.m
//  ezDL
//
//  Created by Robert Witt on 06.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroupsViewController.h"
#import "ServiceFactory.h"


@interface PersonalLibraryGroupsViewController () <PersonalLibraryGroupAddViewControllerDelegate>

@property (nonatomic, strong, readonly) id<PersonalLibraryService> personalLibraryService;
@property (nonatomic, strong, readonly) NSArray *groups;
@property (nonatomic, strong) NSMutableArray *selectedGroups;
@property (nonatomic, strong) NSIndexPath *indexPathOfGroupToDelete;

- (NSString *)cellDetailTitleForGroup:(PersonalLibraryGroup *)group;
- (void)prepareForGroupAddSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)informDelegateWithSelector:(SEL)selector object:(id)object;
- (void)deleteGroupAtIndexPath:(NSIndexPath *)indexPath;
- (void)askToDeleteGroupAtIndexPath:(NSIndexPath *)indexPath;

@end


@implementation PersonalLibraryGroupsViewController

static NSString *SegueIdentifierGroupAdd = @"GroupAddSegue";

@synthesize delegate = _delegate;
@synthesize personalLibraryService = _personalLibraryService;
@synthesize selectedGroups = _selectedGroups;
@synthesize indexPathOfGroupToDelete = _indexPathOfGroupToDelete;

#pragma mark Managing the View

- (id<PersonalLibraryService>)personalLibraryService {
    if (!_personalLibraryService) _personalLibraryService = [[ServiceFactory sharedFactory] personalLibraryService];
    return _personalLibraryService;
}

- (NSArray *)displayedGroups {
    return self.selectedGroups;
}

- (void)setDisplayedGroups:(NSArray *)displayedGroups {
    self.selectedGroups = [NSMutableArray arrayWithArray:displayedGroups];
}

- (NSArray *)groups {
    return [self.personalLibraryService personalLibraryGroups];
}

- (NSMutableArray *)selectedGroups {
    if (!_selectedGroups) _selectedGroups = [NSMutableArray array];
    return _selectedGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    self.delegate = nil;
    _personalLibraryService = nil;
    self.selectedGroups = nil;
    self.indexPathOfGroupToDelete = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (CGSize)contentSizeForViewInPopover {
    NSInteger number = self.groups.count + 1;
    if (number < 5) number = 5;
    
    NSInteger height = number * 44.0f;
    return CGSizeMake(500.0f, height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell"];
    
    PersonalLibraryGroup *group = [self.groups objectAtIndex:indexPath.row];
    cell.textLabel.text = group.name;
    cell.detailTextLabel.text = [self cellDetailTitleForGroup:group];
    
    if ([self.selectedGroups containsObject:group]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (NSString *)cellDetailTitleForGroup:(PersonalLibraryGroup *)group {
    NSString *title = nil;
    
    NSInteger numberOfReferences = group.references.count;
    if (numberOfReferences == 1) {
        title = [NSString stringWithFormat:@"%d %@", numberOfReferences, NSLocalizedString(@"Reference", nil)];
    } else {
        title = [NSString stringWithFormat:@"%d %@", numberOfReferences, NSLocalizedString(@"References", nil)];
    }
    return title;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SegueIdentifierGroupAdd]) {
        [self prepareForGroupAddSegue:segue sender:sender];
    }
}

- (void)informDelegateWithSelector:(SEL)selector object:(id)object {
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate performSelector:selector
                            withObject:self
                            withObject:object];
    }
}

#pragma mark Selecting the Groups

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PersonalLibraryGroup *selectedGroup = [self.groups objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.selectedGroups containsObject:selectedGroup]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectedGroups removeObject:selectedGroup];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedGroups addObject:selectedGroup];
    }
    
    [self informDelegateWithSelector:@selector(groupsViewController:didChangeGroupSelection:) 
                              object:self.selectedGroups];
}

#pragma mark Editing the Groups

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PersonalLibraryGroup *group = [self.groups objectAtIndex:indexPath.row];
        if (group.references.count > 0) {
            // Group has still reference. Ask the user if he really wants to delete the group.
            [self askToDeleteGroupAtIndexPath:indexPath];
        } else {
            [self deleteGroupAtIndexPath:indexPath];
        }
    }
}

- (void)deleteGroupAtIndexPath:(NSIndexPath *)indexPath {
    PersonalLibraryGroup *group = [self.groups objectAtIndex:indexPath.row];
    
    BOOL groupWasSelected = NO;        
    if ([self.selectedGroups containsObject:group]) groupWasSelected = YES;
    
    // Remove group from selected group array and from disk
    [self.selectedGroups removeObject:group];
    [self.personalLibraryService deleteGroup:group];
    
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // Inform delegate
    [self informDelegateWithSelector:@selector(groupsViewController:didDeleteGroup:)
                              object:group];
    
    if (groupWasSelected) {
        [self informDelegateWithSelector:@selector(groupsViewController:didChangeGroupSelection:) 
                                  object:self.selectedGroups];
    }
}

- (void)askToDeleteGroupAtIndexPath:(NSIndexPath *)indexPath {
    PersonalLibraryGroup *group = [self.groups objectAtIndex:indexPath.row];
    self.indexPathOfGroupToDelete = indexPath;
    
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"References Exist Message", nil), group.name];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"References Exist", nil)
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"No", nil)
                                              otherButtonTitles:NSLocalizedString(@"Yes", nil), nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            // Don't delete group
            [self.tableView setEditing:NO animated:YES];
            break;
        case 1:
            // Delete group
            [self deleteGroupAtIndexPath:self.indexPathOfGroupToDelete];
            break;
    }
    
    self.indexPathOfGroupToDelete = nil;
}

#pragma mark Adding a new Group to the Personal Library

- (void)prepareForGroupAddSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PersonalLibraryGroupAddViewController *viewController = segue.destinationViewController;
    viewController.delegate = self;
}

- (void)groupAddViewController:(PersonalLibraryGroupAddViewController *)viewController didSaveGroup:(PersonalLibraryGroup *)group {
    // New group has been created. Add new group to selected groups and reload the table view.
    self.displayedGroups = [self.displayedGroups arrayByAddingObject:group];
    [self.tableView reloadData];
    
    // Inform the delegate
    [self informDelegateWithSelector:@selector(groupsViewController:didChangeGroupSelection:) 
                              object:self.selectedGroups];
    [self informDelegateWithSelector:@selector(groupAddViewController:didSaveGroup:) 
                              object:group];
}

@end
