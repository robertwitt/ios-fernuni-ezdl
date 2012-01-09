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

@interface QueryResultViewController : UITableViewController

@property (nonatomic, strong) QueryResult *queryResult;

@end
