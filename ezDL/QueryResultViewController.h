//
//  QueryResultViewController.h
//  ezDL
//
//  Created by Robert Witt on 20.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResult.h"
#import "QueryController.h"

@interface QueryResultViewController : UITableViewController <QueryControllerDelegate, QueryExecutionViewControllerDelegate>

@property (nonatomic, strong) QueryResult *queryResult;

- (IBAction)editQuery:(UIBarButtonItem *)sender;

@end
