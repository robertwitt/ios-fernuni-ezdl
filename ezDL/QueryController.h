//
//  QueryController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryViewController.h"
#import "QueryExecutionViewController.h"
#import "QueryResult.h"


@class QueryController;
@protocol QueryControllerDelegate <NSObject>

@optional
- (BOOL)queryController:(QueryController *)queryController shouldExecuteQuery:(Query *)query;
- (void)queryController:(QueryController *)queryController willExecuteQuery:(Query *)query;
- (void)queryController:(QueryController *)queryController didExecuteQueryWithQueryResult:(QueryResult *)queryResult;
- (void)queryController:(QueryController *)queryController didFailExecutingQuery:(Query *)query withError:(NSError *)error;
- (void)queryController:(QueryController *)queryController didCancelExecutingQuery:(Query *)query;

@end


@interface QueryController : UIViewController

@property (nonatomic, strong) QueryViewController *queryViewController;
@property (nonatomic, strong) Query *query;
@property (nonatomic, weak) id<QueryControllerDelegate> delegate;

@end
