//
//  DocumentLinkViewController.h
//  ezDL
//
//  Created by Robert Witt on 28.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class DocumentLinkViewController;
@protocol DocumentLinkViewControllerDelegate <NSObject>

- (void)doneWithdocumentLinkViewController:(DocumentLinkViewController *)viewController;

@end


@interface DocumentLinkViewController : UIViewController

@property (nonatomic, strong) NSURL *displayedLink;
@property (nonatomic, weak) id<DocumentLinkViewControllerDelegate> delegate;

@end
