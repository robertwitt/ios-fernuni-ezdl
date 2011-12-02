//
//  PersonalLibraryReferenceAddViewController.m
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryReferenceAddViewController.h"

@implementation PersonalLibraryReferenceAddViewController

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

- (IBAction)save
{
    // TODO Perform saving the document as reference
    PersonalLibraryReference *reference = nil;
    [self.delegate referenceAddViewController:self didSaveReference:reference];
}

@end
