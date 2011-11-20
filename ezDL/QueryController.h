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
- (BOOL)queryController:(QueryController *)queryController shouldExecuteQuery:(id<Query>)query;
- (void)queryController:(QueryController *)queryController willExecuteQuery:(id<Query>)query;
- (void)queryController:(QueryController *)queryController didExecuteQueryWithQueryResult:(QueryResult *)queryResult;
- (void)queryController:(QueryController *)queryController didFailExecutingQuery:(id<Query>)query withError:(NSError *)error;
- (void)queryController:(QueryController *)queryController didCancelExecutingQuery:(id<Query>)query;

@end


@interface QueryController : UIViewController <QueryExecutionViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *clearButton;
@property (nonatomic, weak) IBOutlet UIButton *searchButton;
@property (nonatomic, strong) QueryViewController *queryViewController;
@property (nonatomic, strong) id<Query> query;
@property (nonatomic, weak) id<QueryControllerDelegate> delegate;

- (IBAction)queryTypeChanged:(UISegmentedControl *)sender;
- (IBAction)libraryChoice:(UIBarButtonItem *)sender;
- (IBAction)clear;
- (IBAction)search:(id)sender;
- (void)queryViewGotFilled;
- (void)queryViewGotCleared;
- (void)queryViewSearchKeyPressed;

@end
