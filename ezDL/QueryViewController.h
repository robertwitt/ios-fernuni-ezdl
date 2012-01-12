//
//  QueryViewController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Query.h"

static NSString *QueryViewControllerReturnKeyNotification = @"QueryViewControllerReturnKeyNotification";

/*!
 @class QueryViewController
 @abstract Super class of view controllers that can be contained by the QueryController.
 @discussion The Query Controller can contain view controllers with type of this class. It provides a generic interface for view controllers to be contained in the Query Controller. Concrete subclasses of this view controller are AdvancedQueryViewController and BasicQueryViewController.
 */
@interface QueryViewController : UIViewController

/*!
 @property contentSizeForViewInQueryController
 @abstract Size of the controller's view when it's placed in the Query Controller.
 */
@property (nonatomic, readonly) CGSize contentSizeForViewInQueryController;

/*!
 @property query
 @abstract Query object the controller is displaying in its view.
 */
@property (nonatomic, strong) Query *query;

/*!
 @property viewIsEmpty
 @abstract True if the controller's view is currently empty, i. e. its input fields don't contain any text.
 */
@property (nonatomic, readonly) BOOL viewIsEmpty;

/*!
 @method checkQuerySyntax
 @abstract Checks the syntax of the entered text if a valid query object can be created out of it (abstract).
 @return True if query syntax is correct
 */
- (BOOL)checkQuerySyntax;

/*!
 @method buildQuery
 @abstract Builds a query object by parsing entered text and returns it (abstract).
 @result The created query object
 */
- (Query *)buildQuery;

/*!
 @method clearQueryView
 @abstract Removes all text the user entered from the view (abstract).
 */
- (void)clearQueryView;

/*!
 @method canDisplayQuery:
 @abstract Parses the specified query and checks if it can be displayed in the controller's view.
 @param query A query object
 @result True if query can be displayed
 */
- (BOOL)canDisplayQuery:(Query *)query;

/*!
 @method advancedQueryViewController
 @abstract Creates and returns a new Advanced Query View Controller as QueryViewController.
 @result The new QueryViewController instance
 */
+ (QueryViewController *)advancedQueryViewController;

/*!
 @method basicQueryViewController
 @abstract Creates and returns a new Basic Query View Controller as QueryViewController.
 @result The new QueryViewController instance
 */
+ (QueryViewController *)basicQueryViewController;

@end
