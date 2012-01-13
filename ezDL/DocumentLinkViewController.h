//
//  DocumentLinkViewController.h
//  ezDL
//
//  Created by Robert Witt on 28.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class DocumentLinkViewController;


/*!
 @class DocumentLinkViewControllerDelegate
 @abstract Delegate of the Document Link View Controller
 @discussion The view controller notifies the object which implements this protocol and sets itself to the DocumentLinkViewController's delegate property about user actions.
 */
@protocol DocumentLinkViewControllerDelegate <NSObject>

/*!
 @method doneWithdocumentLinkViewController:
 @abstract Sent to delegate if user taps on done button in toolbar
 @param viewController The DocumentLinkViewController instance
 */
- (void)doneWithdocumentLinkViewController:(DocumentLinkViewController *)viewController;

@end


/*!
 @class DocumentLinkViewController
 @abstract Displays a document link in a web view
 @discussion The view controller's view contains a web view that loads web content at specified URL and shows it to the user.
 */
@interface DocumentLinkViewController : UIViewController

/*!
 @property displayedLink
 @abstract URL the web view should load and display
 */
@property (nonatomic, strong) NSURL *displayedLink;

/*!
 @property delegate
 @abstract Optional delegate of this view controller
 */
@property (nonatomic, weak) id<DocumentLinkViewControllerDelegate> delegate;

@end
