//
//  QueryResultSortingViewController.h
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultSorting.h"


@class QueryResultSortingViewController;
@protocol QueryResultSortingViewControllerDelegate <NSObject>

- (void)queryResultSortingViewController:(QueryResultSortingViewController *)viewController didSelectSorting:(QueryResultSorting *)sorting;

@end


@interface QueryResultSortingViewController : UITableViewController

@property (nonatomic, strong) QueryResultSorting *currentSorting;
@property (nonatomic, weak) id<QueryResultSortingViewControllerDelegate> delegate;

@end
