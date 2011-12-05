//
//  PersonalLibraryReferenceAddViewController.m
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryReferenceAddViewController.h"
#import "ServiceFactory.h"

// TODO Temporary imports
#import "CoreDataStack.h"


@interface PersonalLibraryReferenceAddViewController ()

@property (nonatomic, strong, readonly) id<PersonalLibraryService> personalLibraryService;
@property (nonatomic, weak) PersonalLibraryGroup *selectedGroup;

- (void)prepareForAddGroupSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (Document *)convertDocumentToManagedObject;

@end


@implementation PersonalLibraryReferenceAddViewController

static NSString *SegueIdentifierAddGroup = @"AddGroupSegue";

@synthesize groupTableView = _groupTableView;
@synthesize keyWordsTextField = _keyWordsTextField;
@synthesize notesTextView = _notesTextView;
@synthesize referenceDocument = _referenceDocument;
@synthesize delegate = _delegate;
@synthesize personalLibraryService = _personalLibraryService;
@synthesize selectedGroup = _selectedGroup;

#pragma mark Managing the View

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.personalLibraryService personalLibraryGroups].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell"];
    
    PersonalLibraryGroup *group = [[self.personalLibraryService personalLibraryGroups] objectAtIndex:indexPath.row];
    cell.textLabel.text = group.name;
    
    // Showing checkmark for selected group
    if (!self.selectedGroup && indexPath.row == 0)
    {
        // Mark first row as selected
        self.selectedGroup = group;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (self.selectedGroup == group)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (IBAction)cancel
{
    [self.delegate didCancelReferenceAddViewController:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SegueIdentifierAddGroup])
    {
        [self prepareForAddGroupSegue:segue sender:sender];
    }
}

- (IBAction)save
{
    // Perform saving the document as reference
    
    // TODO Temporary implementation
    Document *document = [self convertDocumentToManagedObject];
    PersonalLibraryReference *reference = [self.personalLibraryService newReferenceWithDocument:document];
    reference.group = self.selectedGroup;
    reference.keywordString = self.keyWordsTextField.text;
    reference.note = self.notesTextView.text;
    
    [self.personalLibraryService saveReference:reference];
    
    [self.delegate referenceAddViewController:self didSaveReference:reference];
}

- (id<PersonalLibraryService>)personalLibraryService
{
    if (!_personalLibraryService) _personalLibraryService = [[ServiceFactory sharedFactory] personalLibraryService];
    return _personalLibraryService;
}

- (Document *)convertDocumentToManagedObject
{
    NSManagedObjectContext *managedObjectContext = [CoreDataStack sharedCoreDataStack].managedObjectContext;
    NSMutableSet *authors = [NSMutableSet set];
    for (Author *author in self.referenceDocument.authors)
    {
        Author *authorMO = (Author *)[NSEntityDescription insertNewObjectForEntityForName:CoreDataEntityAuthor
                                                                       inManagedObjectContext:managedObjectContext];
        authorMO.firstName = author.firstName;
        authorMO.lastName = author.lastName;
        [authors addObject:authorMO];
    }
    
    Document *document = (Document *)[NSEntityDescription insertNewObjectForEntityForName:CoreDataEntityDocument
                                                                       inManagedObjectContext:managedObjectContext];
    document.title = self.referenceDocument.title;
    document.year = self.referenceDocument.year;
    document.authors = authors;
    
    return document;
}

#pragma mark Putting Reference into Groups in Personal Library

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedGroup = [[self.personalLibraryService personalLibraryGroups] objectAtIndex:indexPath.row];
    [tableView reloadData];
}

- (void)prepareForAddGroupSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PersonalLibraryGroupAddViewController *viewController = segue.destinationViewController;
    viewController.delegate = self;
}

- (void)groupAddViewController:(PersonalLibraryGroupAddViewController *)viewController didSaveGroup:(PersonalLibraryGroup *)group
{
    // React on saving the group. Adds it to table view and marks it automatically. Scroll to new row.
    self.selectedGroup = group;
    NSInteger index = [[self.personalLibraryService personalLibraryGroups] indexOfObject:group];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.groupTableView reloadData];
    [self.groupTableView scrollToRowAtIndexPath:indexPath 
                               atScrollPosition:UITableViewScrollPositionMiddle 
                                       animated:YES];
}

@end
