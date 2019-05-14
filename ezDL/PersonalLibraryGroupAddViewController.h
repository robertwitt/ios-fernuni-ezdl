//
//  PersonalLibraryGroupAddViewController.h
//  ezDL
//
//  Created by Robert Witt on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class PersonalLibraryGroupAddViewController;


/*!
 @protocol PersonalLibraryGroupAddViewControllerDelegate
 @abstract Delegate of the PersonalLibraryGroupAddViewController
 @discussion Classes that implement this protocol will be notified if a group has been saved.
 */
@protocol PersonalLibraryGroupAddViewControllerDelegate <NSObject>

/*!
 @method groupAddViewController:didSaveGroup:
 @abstract Sent to delegate if user has saved a group
 @param viewController The PersonalLibraryGroupAddViewController as sender
 @param group The PersonalLibrarygroup that has been created
 */
- (void)groupAddViewController:(PersonalLibraryGroupAddViewController *)viewController didSaveGroup:(PersonalLibraryGroup *)group;

@end


/*!
 @class PersonalLibraryGroupAddViewController
 @abstract View controller to add a PersonalLibraryGroup to the Personal Library
 @discussion The controller's view consist of a text field to enter a group name. The Delegate protocol PersonalLibraryGroupAddViewControllerDelegate offers opportunity for clients to get notified when the group has been saved.
 */
@interface PersonalLibraryGroupAddViewController : UIViewController

/*!
 @property delegate
 @abstract Will be notified when user has saved a group
 */
@property (nonatomic, weak) id<PersonalLibraryGroupAddViewControllerDelegate> delegate;

@end
