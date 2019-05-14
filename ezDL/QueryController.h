//
//  QueryController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryViewController.h"
#import "QueryResult.h"


@class QueryController;

/*!
 @protocol QueryControllerDelegate
 @abstract Delegate of the Query Controller.
 @discussion Optional delegate to inform clients of the Query Controller about query execution status.
 */
@protocol QueryControllerDelegate <NSObject>

@optional

/*!
 @method queryController:shouldExecuteQuery:
 @abstract Asks the delegate whether or not the Query Controller should execute the query when the search button is hit.
 @param queryController Query Controller
 @param query Query object built by the Query Controller
 @result If true, Query Controller executes the query
 @discussion If the delegate returns yes, the Query Controller calls the Query Execution View Controller to execute the query. If not, it does nothing. Then it lies in the hands of the delegate to execute the query itself.
 */
- (BOOL)queryController:(QueryController *)queryController shouldExecuteQuery:(Query *)query;

/*!
 @method queryController:willExecuteQuery:
 @abstract Sent to delegate right before query is executed.
 @param queryController Query Controller
 @param query Query object built by the Query Controller
 */
- (void)queryController:(QueryController *)queryController willExecuteQuery:(Query *)query;

/*!
 @method queryController:didExecuteQueryWithQueryResult:
 @abstract Query result is sent to delegate after successful execution of the query.
 @param queryController Query Controller
 @param queryResult Result of the query
 */
- (void)queryController:(QueryController *)queryController didExecuteQueryWithQueryResult:(QueryResult *)queryResult;

/*!
 @method queryController:didFailExecutingQuery:withError:
 @abstract Sent to delegate if executing query has failed.
 @param queryController Query Controller
 @param query Query object built by the Query Controller
 @param error Error object containing the reason for the failure
 */
- (void)queryController:(QueryController *)queryController didFailExecutingQuery:(Query *)query withError:(NSError *)error;

/*!
 @method queryController:didCancelExecutingQuery:
 @abstract Sent to delegate if user has cancelled the query execution.
 @param queryController Query Controller
 @param query Query object built by the Query Controller
 */
- (void)queryController:(QueryController *)queryController didCancelExecutingQuery:(Query *)query;

@end


/*!
 @class QueryController
 @abstract View Controller that manages entering and building a valid query.
 @discussion This view controller is the top most view controller and is embedded in a navigation controller sequence. It implements the first step in the three-step procedure of performing a search in ezDL, to enter a query to search with in ezDL. The other steps are managing the results of this query and displaying one result entry in detail.
 The view controller is implemented as container view controller as they are possible with iOS 5. It manages another view controller and displays its view called the Query View Controller. Therefore it has a public property queryViewController which represents the currently displayed Query View Controller. However, mostly it manages the contained view controller by itself which is either an AdvancedQueryViewController or a BasicQueryViewController instance.
 The view controller's view contains a segmented control to switch between the Query View Controller subtypes and two buttons, to clear the query view and execute search.
 Clients can set a delegate to get notified about query execution. They have to implement the QueryControllerDelegate protocol.
 */
@interface QueryController : UIViewController

/*!
 @property queryViewController
 @abstract Contained view controller with a query view.
 */
@property (nonatomic, strong) QueryViewController *queryViewController;

/*!
 @property query
 @abstract Query object the controller is displaying in its view.
 */
@property (nonatomic, strong) Query *query;

/*!
 @property delegate
 @abstract Optional delegate to inform clients query execution status.
 */
@property (nonatomic, weak) id<QueryControllerDelegate> delegate;

@end
