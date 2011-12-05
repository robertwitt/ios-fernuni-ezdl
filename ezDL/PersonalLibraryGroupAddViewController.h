//
//  PersonalLibraryGroupAddViewController.h
//  ezDL
//
//  Created by Robert Witt on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroup.h"


@class PersonalLibraryGroupAddViewController;
@protocol PersonalLibraryGroupAddViewControllerDelegate <NSObject>

- (void)groupAddViewController:(PersonalLibraryGroupAddViewController *)viewController didSaveGroup:(PersonalLibraryGroup *)group;

@end


@interface PersonalLibraryGroupAddViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *groupNameTextField;
@property (nonatomic, weak) id<PersonalLibraryGroupAddViewControllerDelegate> delegate;

- (IBAction)save;

@end
