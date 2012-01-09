//
//  QueryExecutionViewController.h
//  ezDL
//
//  Created by Robert Witt on 20.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResult.h"


@class QueryExecutionViewController;
@protocol QueryExecutionViewControllerDelegate <NSObject>

- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didCancelExecutingQuery:(Query *)query;
- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didExecuteQueryWithQueryResult:(QueryResult *)queryResult;
- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didFailExecutingQuery:(Query *)query withError:(NSError *)error;

@end


@interface QueryExecutionViewController : UIViewController

@property (nonatomic, strong) Query *queryToExecute;
@property (nonatomic, weak) id<QueryExecutionViewControllerDelegate> delegate;

@end
