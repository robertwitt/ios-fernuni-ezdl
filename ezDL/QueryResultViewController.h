//
//  QueryResultViewController.h
//  ezDL
//
//  Created by Robert Witt on 20.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResult.h"

/*!
 @class QueryResultViewController
 @abstract Displays a query result in a table view
 @discussion The view controller is a table view controller with its own table cell type. One row shows one result entry, i. e. one document.
 The Query Result View Controller doesn't determine the result of a query by itself but it gets a query result object assigned to property queryResult.
 */
@interface QueryResultViewController : UITableViewController

/*!
 @property queryResult
 @abstract Query result object to display in table view
 */
@property (nonatomic, strong) QueryResult *queryResult;

@end
