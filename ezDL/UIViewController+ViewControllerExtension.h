//
//  UIViewController+ViewControllerExtension.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


/*!
 @category ViewControllerExtension
 @abstract Enhancement of UIViewController
 @discussion This category implements methods that are really helpful when implementing a view controller to minimize redundant coding.
 */
@interface UIViewController (ViewControllerExtension) <UIAlertViewDelegate>

/*!
 @method startNetworkActivity
 @abstract Starts the network activity indicator in the application status bar
 */
- (void)startNetworkActivity;

/*!
 @method stopNetworkActivity
 @property Stops the network activity indicator in the application status bar
 */
- (void)stopNetworkActivity;

/*!
 @method toggleNetworkActivity
 @property Toggles the network activity indicator in the application status bar
 */
- (void)toggleNetworkActivity;

/*!
 @method showSimpleAlertWithTitle:message:tag:
 @abstract Shows an UIAlertView with an OK button and the given title and message.
 @param title Title in the alert view
 @param message Message in the alert view
 @param tag Tag of the alert view
 */
- (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message tag:(NSInteger)tag;

/*!
 @method openURL:
 @abstract Opens an URL in Safari.
 @param url The URL to show
 */
- (void)openURL:(NSURL *)url;

/*!
 @method startObservingObject:notificationName:selector:
 @abstract Start observing specified notifications for a given object.
 @param object The object that should be observed by the view controller
 @param name Name of notification to look for
 @param selector Method selector invoked when notification has been received
 */
- (void)startObservingObject:(id)object notificationName:(NSString *)name selector:(SEL)selector;

/*!
 @method stopObservingObject:notificationName:
 @abstract Stops observing an object
 @param object The object that shouldn't be observed anymore
 @param name Name of notification
 */
- (void)stopObservingObject:(id)object notificationName:(NSString *)name;

/*!
 @method postNotificationWithName:
 @abstract Post a notification with specified name
 @param name Name of notification to be sent
 */
- (void)postNotificationWithName:(NSString *)notificationName;

@end
