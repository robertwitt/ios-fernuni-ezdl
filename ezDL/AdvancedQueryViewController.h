//
//  AdvancedQueryViewController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryViewController.h"

/*!
 @class AdvancedQueryViewController
 @abstract View controller to depict an advanced query
 @discussion The view controller's view contains four text fields (for text, title, author, and year) to enter single keywords or nested expressions, but always seperated by these four attributes.
 The superclass is QueryViewController to hide the details of the advanced query implemented from clients (the Query Controller).
 */
@interface AdvancedQueryViewController : QueryViewController

@end
