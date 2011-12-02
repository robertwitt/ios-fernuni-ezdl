//
//  QueryResultOptionsViewController.m
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultOptionsViewController.h"

@implementation QueryResultOptionsViewController

#pragma mark Managing the View

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (CGSize)contentSizeForViewInPopover
{
    return CGSizeMake(400.0f, 64.0f);
}

@end
