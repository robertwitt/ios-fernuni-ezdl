//
//  BasicQueryViewController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryViewController.h"

/*!
 @class BasicQueryViewController
 @abstract View controller to depict an basic query
 @discussion The view controller's view contains a big text view. You can use it to enter single keywords to build a more coarse query. However, you can also build complex nested query expressions with logical connectors, brackets, etc.
 The superclass is QueryViewController to hide the details of the advanced query implemented from clients (the Query Controller).
 */
@interface BasicQueryViewController : QueryViewController

@end
