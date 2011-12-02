//
//  QueryResultViewController.h
//  ezDL
//
//  Created by Robert Witt on 20.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResult.h"
#import "QueryController.h"
#import "QueryResultSortingViewController.h"
#import "QueryResultGroupingViewController.h"
#import "DocumentDetailViewController.h"

@interface QueryResultViewController : UITableViewController <QueryControllerDelegate, QueryExecutionViewControllerDelegate, QueryResultSortingViewControllerDelegate, QueryResultGroupingViewControllerDelegate, UISearchBarDelegate, DocumentDetailViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableViewCell *queryResultCell;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *sortByItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *groupByItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *optionsItem;
@property (nonatomic, strong) QueryResult *queryResult;

- (IBAction)editQuery:(UIBarButtonItem *)sender;
- (IBAction)sortBy:(UIBarButtonItem *)sender;
- (IBAction)groupBy:(UIBarButtonItem *)sender;
- (IBAction)openOptions:(UIBarButtonItem *)sender;

@end
