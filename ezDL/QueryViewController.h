//
//  QueryViewController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Query.h"

static NSString *QueryViewGotFilledNotification = @"QueryViewGotFilledNotification";
static NSString *QueryViewGotClearedNotification = @"QueryViewGotClearedNotification";
static NSString *QueryViewSearchRequestedNotification = @"QueryViewSearchRequestedNotification";

@interface QueryViewController : UIViewController

@property (nonatomic, readonly) CGSize contentSizeForViewInQueryController;
@property (nonatomic, strong) id<Query> query;

- (id<Query>)buildQuery;
- (void)clearQueryView;

+ (QueryViewController *)advancedQueryViewController;
+ (QueryViewController *)basicQueryViewController;

@end
