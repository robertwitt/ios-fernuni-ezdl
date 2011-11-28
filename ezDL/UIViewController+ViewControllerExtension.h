//
//  UIViewController+ViewControllerExtension.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface UIViewController (ViewControllerExtension) <UIAlertViewDelegate>

- (void)startNetworkActivity;
- (void)stopNetworkActivity;
- (void)toggleNetworkActivity;
- (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message tag:(NSInteger)tag;
- (void)openURL:(NSURL *)url;

@end
