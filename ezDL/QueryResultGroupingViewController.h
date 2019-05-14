//
//  QueryResultGroupingViewController.h
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultGrouping.h"


@class QueryResultGroupingViewController;

/*!
 @protocol QueryResultGroupingViewControllerDelegate
 @abstract Delegate protocol of the Query Result Grouping View Controller
 @discussion Clients of the QueryResultGroupingViewController that want to be notified about user's selections have to implement this protocol.
 */
@protocol QueryResultGroupingViewControllerDelegate <NSObject>

/*!
 @method queryResultGroupingViewController:didSelectGrouping:
 @abstract Sent to delegate if the user has changed the selection, i. e. has tapped on rows in the table view.
 @param viewController The Query Result Grouping View Controller the selection has been changed in
 @param grouping New grouping object after user has changed the selection
 */
- (void)queryResultGroupingViewController:(QueryResultGroupingViewController *)viewController didSelectGrouping:(QueryResultGrouping *)grouping;

@end


/*!
 @class QueryResultGroupingViewController
 @abstract View controller o group a QueryResult by defined criteria.
 @discussion This table view controller lists all criteria a QueryResult object can be grouped by. Users can change the grouping by tapping on the desired option which is assembled in a QueryResultGrouping object.
 The view controller communicates changes in selection by its delegate represented by QueryResultGroupingViewControllerDelegate protocol.
 */
@interface QueryResultGroupingViewController : UITableViewController

/*!
 @property currentGrouping
 @abstract The grouping currently set in the controller
 */
@property (nonatomic, strong) QueryResultGrouping *currentGrouping;

/*!
 @property delegate
 @abstract Delegate of this view controller which must conform to QueryResultGroupingViewControllerDelegate protocol
 */
@property (nonatomic, weak) id<QueryResultGroupingViewControllerDelegate> delegate;

@end
