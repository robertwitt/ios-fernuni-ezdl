//
//  AppDelegate.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @class AppDelegate
 @abstract Delegate of the ezDL iOS application
 @discussion The application delegate is a mandatory object an iOS application must have. It conforms to the UIApplicationDelegate protocol and its only responsibility is to manage the application's window.
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>

/*!
 @property window
 @abstract The application's window
 */
@property (strong, nonatomic) UIWindow *window;

@end
