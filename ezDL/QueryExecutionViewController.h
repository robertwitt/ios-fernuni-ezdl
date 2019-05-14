//
//  QueryExecutionViewController.h
//  ezDL
//
//  Created by Robert Witt on 20.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResult.h"


@class QueryExecutionViewController;

/*!
 @protocol QueryExecutionViewControllerDelegate
 @abstract Delegate protocol of Query Execution View Controller
 @discussion The main purpose of this protocol is to notify interested clients about the query execution status, especially to tell it the query result.
 */
@protocol QueryExecutionViewControllerDelegate <NSObject>

/*!
 @method queryExecutionViewController:didCancelExecutingQuery:
 @abstract Sent to delegate if user has cancelled the query execution.
 @param queryExecutionViewController Query Execution View Controller
 @param query Query object to be executed
 */
- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didCancelExecutingQuery:(Query *)query;

/*!
 @method queryExecutionViewController:didExecuteQueryWithQueryResult:
 @abstract Query result is sent to delegate after successful execution of the query.
 @param queryExecutionViewController Query Execution View Controller
 @param queryResult Result of the query
 */
- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didExecuteQueryWithQueryResult:(QueryResult *)queryResult;

/*!
 @method queryExecutionViewController:didFailExecutingQuery:withError:
 @abstract Sent to delegate if executing query has failed.
 @param queryExecutionViewController Query Execution View Controller
 @param query Query object to be executed
 @param error Error object containing the reason for the failure
 */
- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didFailExecutingQuery:(Query *)query withError:(NSError *)error;

@end


/*!
 @class QueryExecutionViewController
 @abstract View controller to call the ezDL backend and execute a query.
 @discussion The view controllers communicates the actual result of a query object via its delegate which has to implement the QueryExecutionViewControllerDelegate protocol.
 */
@interface QueryExecutionViewController : UIViewController

/*!
 @property queryToExecute
 @abstract The query object the Query Execution View Controller should execute.
 */
@property (nonatomic, strong) Query *queryToExecute;

/*!
 @property delegate
 @abstract Optional delegate to notify about query execution status.
 */
@property (nonatomic, weak) id<QueryExecutionViewControllerDelegate> delegate;

@end
