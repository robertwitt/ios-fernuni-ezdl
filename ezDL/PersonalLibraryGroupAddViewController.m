//
//  PersonalLibraryGroupAddViewController.m
//  ezDL
//
//  Created by Robert Witt on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroupAddViewController.h"

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
    PersonalLibraryGroup *group = nil;
    
    // TODO Call service to create a new group
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate groupAddViewController:self didSaveGroup:group];
}

@end
