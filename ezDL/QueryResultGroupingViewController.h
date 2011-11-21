//
//  QueryResultGroupingViewController.h
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultGrouping.h"


@class QueryResultGroupingViewController;
@protocol QueryResultGroupingViewControllerDelegate <NSObject>

- (void)queryResultGroupingViewController:(QueryResultGroupingViewController *)viewController didSelectGrouping:(QueryResultGrouping *)grouping;

@end


@interface QueryResultGroupingViewController : UITableViewController

@property (nonatomic, strong) QueryResultGrouping *currentGrouping;
@property (nonatomic, weak) id<QueryResultGroupingViewControllerDelegate> delegate;

@end
