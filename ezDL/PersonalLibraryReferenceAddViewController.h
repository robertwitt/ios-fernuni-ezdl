//
//  PersonalLibraryReferenceAddViewController.h
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroupAddViewController.h"


@class PersonalLibraryReferenceAddViewController;


/*!
 @protocol PersonalLibraryReferenceAddViewControllerDelegate
 @abstract Delegate of the PersonalLibraryReferenceAddViewController
 @discussion Classes that implement this protocol will be notified if a references has been saved.
 */
@protocol PersonalLibraryReferenceAddViewControllerDelegate <NSObject>

/*!
 @method didCancelReferenceAddViewController:
 @abstract Sent to delegate if user has cancelled the process
 @param viewController The PersonalLibraryReferenceAddViewController as sender
 */
- (void)didCancelReferenceAddViewController:(PersonalLibraryReferenceAddViewController *)viewController;

/*!
 @method referenceAddViewController:didSaveReference:
 @abstract Sent to delegate if user has saved a reference
 @param viewController The PersonalLibraryReferenceAddViewController as sender
 @param reference The PersonalLibraryReference that has been created
 */
- (void)referenceAddViewController:(PersonalLibraryReferenceAddViewController *)viewController didSaveReference:(PersonalLibraryReference *)reference;

@end


/*!
 @class PersonalLibraryReferenceAddViewController
 @abstract View controller to add a Document as PersonalLibraryReference to the Personal Library
 @discussion The controller's view consist of a form sheet where the user can select the group the document should be added to as well as note and keyword input fields. After entering all data the user can decide to save the reference to the Personal Library.
 The Delegate protocol PersonalLibraryReferenceAddViewControllerDelegate offers opportunity for clients to get notified when the reference has been saved.
 */
@interface PersonalLibraryReferenceAddViewController : UIViewController

/*!
 @property referenceDocument
 @abstract The Document the reference should be created with
 */
@property (nonatomic, strong) Document *referenceDocument;

/*!
 @property delegate
 @abstract Will be notified when user has saved a reference
 */
@property (nonatomic, weak) id<PersonalLibraryReferenceAddViewControllerDelegate> delegate;

@end
