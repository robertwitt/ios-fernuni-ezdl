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
@protocol QueryControllerDelegate <NSObject>

@optional
- (BOOL)queryController:(QueryController *)queryController shouldExecuteQuery:(id<Query>)query;
- (void)queryController:(QueryController *)queryController willExecuteQuery:(id<Query>)query;
- (void)queryController:(QueryController *)queryController didExecuteQueryWithQueryResult:(QueryResult *)queryResult;
- (void)queryController:(QueryController *)queryController didFailExecutingQuery:(id<Query>)query withError:(NSError **)error;

@end


@interface QueryController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *clearButton;
@property (nonatomic, weak) IBOutlet UIButton *searchButton;
@property (nonatomic, strong) QueryViewController *queryViewController;
@property (nonatomic, strong) id<Query> query;
@property (nonatomic, weak) id<QueryControllerDelegate> delegate;

- (IBAction)queryTypeChanged:(UISegmentedControl *)sender;
- (IBAction)libraryChoice:(UIBarButtonItem *)sender;
- (IBAction)clear;
- (IBAction)search;
- (void)queryViewGotFilled;
- (void)queryViewGotCleared;

@end
