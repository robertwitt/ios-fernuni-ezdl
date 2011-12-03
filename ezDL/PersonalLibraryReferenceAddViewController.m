//
//  PersonalLibraryReferenceAddViewController.m
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryReferenceAddViewController.h"


@interface PersonalLibraryReferenceAddViewController ()

- (void)prepareForAddGroupSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end


@implementation PersonalLibraryReferenceAddViewController

static NSString *SegueIdentifierAddGroup = @"AddGroupSegue";

@synthesize keyWordsTextField = _keyWordsTextField;
@synthesize notesTextView = _notesTextView;
@synthesize referenceDocument = _referenceDocument;
@synthesize delegate = _delegate;

#pragma mark Managing the View

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // TODO Implementation needed
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell"];
    
    // TODO Implementation needed
    
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
    // TODO Perform saving the document as reference
    PersonalLibraryReference *reference = nil;
    [self.delegate referenceAddViewController:self didSaveReference:reference];
}

#pragma mark Creating new Groups in Personal Library

- (void)prepareForAddGroupSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PersonalLibraryGroupAddViewController *viewController = segue.destinationViewController;
    viewController.delegate = self;
}

- (void)groupAddViewController:(PersonalLibraryGroupAddViewController *)viewController didSaveGroup:(PersonalLibraryGroup *)group
{
    // TODO React on saving the group. Adds it to table view controller and marks it automatically. Reload table view animated.
}

@end
