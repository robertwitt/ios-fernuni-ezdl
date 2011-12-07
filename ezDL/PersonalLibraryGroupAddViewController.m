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
@synthesize saveItem = _saveItem;
@synthesize delegate = _delegate;

#pragma mark Managing the View

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (CGSize)contentSizeForViewInPopover
{
    return CGSizeMake(500.0f, 200.0f);
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *textAfterChange = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textAfterChange isNilOrEmpty]) self.saveItem.enabled = NO;
    else self.saveItem.enabled = YES;
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.saveItem.enabled = NO;    
    return YES;
}

@end
