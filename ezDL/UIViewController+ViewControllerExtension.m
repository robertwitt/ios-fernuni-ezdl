//
//  UIViewController+ViewControllerExtension.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+ViewControllerExtension.h"

@implementation UIViewController (ViewControllerExtension)

- (void)startNetworkActivity
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)stopNetworkActivity
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)toggleNetworkActivity
{
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = !application.networkActivityIndicatorVisible;
}

@end
