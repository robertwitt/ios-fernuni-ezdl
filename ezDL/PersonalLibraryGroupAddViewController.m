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
    id<PersonalLibraryService> service = [[ServiceFactory sharedFactory] personalLibraryService];
    
    NSString *groupName = self.groupNameTextField.text;
    PersonalLibraryGroup *group = [service newGroupWithName:groupName];
    [service saveGroup:group];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate groupAddViewController:self didSaveGroup:group];
}

@end
