//
//  QueryViewController.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryViewController.h"
#import "AdvancedQueryViewController.h"
#import "BasicQueryViewController.h"

@implementation QueryViewController

@synthesize contentSizeForViewInQueryController = _contentSizeForViewInQueryController;
@synthesize query = _query;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
}

- (void)viewDidUnload
{
    self.query = nil;
    [super viewDidUnload];
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

- (BOOL)checkQuerySyntax { return NO; }

- (Query *)buildQuery { return nil; }

- (void)clearQueryView {}

+ (AdvancedQueryViewController *)advancedQueryViewController
{
    AdvancedQueryViewController *viewController = [[AdvancedQueryViewController alloc] initWithNibName:@"AdvancedQueryViewController"
                                                                                                bundle:nil];
    return viewController;
    
}

+ (BasicQueryViewController *)basicQueryViewController
{

    BasicQueryViewController *viewController = [[BasicQueryViewController alloc] initWithNibName:@"BasicQueryViewController" 
                                                                                          bundle:nil];
    return viewController;
}

@end
