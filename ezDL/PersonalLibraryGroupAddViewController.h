//
//  PersonalLibraryGroupAddViewController.h
//  ezDL
//
//  Created by Robert Witt on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class PersonalLibraryGroupAddViewController;
@protocol PersonalLibraryGroupAddViewControllerDelegate <NSObject>

- (void)groupAddViewController:(PersonalLibraryGroupAddViewController *)viewController didSaveGroup:(PersonalLibraryGroup *)group;

@end


@interface PersonalLibraryGroupAddViewController : UIViewController

@property (nonatomic, weak) id<PersonalLibraryGroupAddViewControllerDelegate> delegate;

@end
