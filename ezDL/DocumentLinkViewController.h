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


@interface DocumentLinkViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIBarButtonItem *backItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *forwardItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *safariItem;
@property (nonatomic, weak) IBOutlet UITextField *linkTextField;
@property (nonatomic, weak) IBOutlet UIWebView *linkWebView;
@property (nonatomic, strong) NSURL *displayedLink;
@property (nonatomic, weak) id<DocumentLinkViewControllerDelegate> delegate;

- (IBAction)goBack;
- (IBAction)goForward;
- (IBAction)openInSafari;
- (IBAction)done;

@end
