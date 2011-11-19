//
//  QueryViewController.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryViewController.h"

@implementation QueryViewController

@synthesize contentSizeForViewInQueryController = _contentSizeForViewInQueryController;
@synthesize query = _query;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (CGSize)contentSizeForViewInQueryController
{
    CGSize size;
    size.width = self.view.superview.frame.size.width - 40.0f;
    size.height = 260.0f;
    
    return size;
}

- (id<Query>)buildQuery { return nil; }

- (void)clearQueryView {}

@end
