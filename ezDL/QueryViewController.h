//
//  QueryViewController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Query.h"

static NSString *QueryViewControllerReturnKeyNotification = @"QueryViewControllerReturnKeyNotification";

@interface QueryViewController : UIViewController

@property (nonatomic, readonly) CGSize contentSizeForViewInQueryController;
@property (nonatomic, strong) Query *query;
@property (nonatomic, readonly) BOOL viewIsEmpty;

- (BOOL)checkQuerySyntax;
- (Query *)buildQuery;
- (void)clearQueryView;
- (BOOL)canDisplayQuery:(Query *)query;

+ (QueryViewController *)advancedQueryViewController;
+ (QueryViewController *)basicQueryViewController;

@end
