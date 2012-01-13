//
//  QueryResultSortingViewController.h
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultSorting.h"


@class QueryResultSortingViewController;

/*!
 @protocol QueryResultSortingViewControllerDelegate
 @abstract Delegate protocol of the Query Result Sorting View Controller
 @discussion Clients of the QueryResultSortingViewController that want to be notified about user's selections have to implement this protocol.
 */
@protocol QueryResultSortingViewControllerDelegate <NSObject>

/*!
 @method queryResultSortingViewController:didSelectSorting:
 @abstract Sent to delegate if the user has changed the selection, i. e. has tapped on rows in the table view.
 @param viewController The Query Result Sorting View Controller the selection has been changed in
 @param sorting New sorting object after user has changed the selection
 */
- (void)queryResultSortingViewController:(QueryResultSortingViewController *)viewController didSelectSorting:(QueryResultSorting *)sorting;

@end


/*!
 @class QueryResultSortingViewController
 @abstract View controller o sort a QueryResult by defined criteria.
 @discussion This table view controller lists all criteria a QueryResult object can be sorted by. Users can change the sorting by tapping on the desired option which is assembled in a QueryResultSorting object.
 The view controller communicates changes in selection by its delegate represented by QueryResultSortingViewControllerDelegate protocol.
 */
@interface QueryResultSortingViewController : UITableViewController

/*!
 @property currentSorting
 @abstract The sorting currently set in the controller
 */
@property (nonatomic, strong) QueryResultSorting *currentSorting;

/*!
 @property delegate
 @abstract Delegate of this view controller which must conform to QueryResultSortingViewControllerDelegate protocol
 */
@property (nonatomic, weak) id<QueryResultSortingViewControllerDelegate> delegate;

@end
