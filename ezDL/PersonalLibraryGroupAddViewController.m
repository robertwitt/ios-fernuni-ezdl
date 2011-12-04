//
//  PersonalLibraryGroupAddViewController.m
//  ezDL
//
//  Created by Robert Witt on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroupAddViewController.h"
#import "ServiceFactory.h"

@implementation PersonalLibraryGroupAddViewController

@synthesize groupNameTextField = _groupNameTextField;
@synthesize delegate = _delegate;

#pragma mark Managing the View

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)save
{
    NSString *groupName = self.groupNameTextField.text;
    PersonalLibraryGroupMO *group = [[[ServiceFactory sharedFactory] personalLibraryService] newGroupWithName:groupName];
    [[[ServiceFactory sharedFactory] personalLibraryService] saveGroup:group];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate groupAddViewController:self didSaveGroup:group];
}

@end
