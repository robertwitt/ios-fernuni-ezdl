//
//  UIViewController+ViewControllerExtension.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+ViewControllerExtension.h"

@implementation UIViewController (ViewControllerExtension)

- (void)startNetworkActivity {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)stopNetworkActivity {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)toggleNetworkActivity {
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = !application.networkActivityIndicatorVisible;
}

- (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message tag:(NSInteger)tag {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
    alertView.tag = tag;
    [alertView show];
}

- (void)openURL:(NSURL *)url {
    [[UIApplication sharedApplication] openURL:url];
}

- (void)startObservingObject:(id)object notificationName:(NSString *)name selector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:name
                                               object:object];
}

- (void)stopObservingObject:(id)object notificationName:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:object];
}

- (void)postNotificationWithName:(NSString *)notificationName {
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName
                                                        object:self];
}

@end
