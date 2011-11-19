//
//  QueryController.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryController.h"
#import "AdvancedQueryViewController.h"
#import "BasicQueryViewController.h"
#import "LibraryChoiceViewController.h"


@interface QueryController ()

@property (nonatomic, strong, readonly) AdvancedQueryViewController *advancedQueryViewController;
@property (nonatomic, strong, readonly) BasicQueryViewController *basicQueryViewController;
@property (nonatomic, strong) UIPopoverController *libraryChoicePopover;

@end


@implementation QueryController

@synthesize queryViewController = _queryViewController;
@synthesize advancedQueryViewController = _advancedQueryViewController;
@synthesize basicQueryViewController = _basicQueryViewController;
@synthesize libraryChoicePopover = _libraryChoicePopover;

- (void)setQueryViewController:(QueryViewController *)queryViewController 
{
    // Remove the old query view controller from its super view controller
    [_queryViewController.view removeFromSuperview];
    [_queryViewController removeFromParentViewController];
    
    // Add new view controller as child
    [queryViewController willMoveToParentViewController:self];
    [self addChildViewController:queryViewController];
    [self.view addSubview:queryViewController.view];
    
    // Set view's frame
    CGRect frame;
    frame.origin.x = 20.0f;
    frame.origin.y = 71.0f;
    frame.size = queryViewController.contentSizeForViewInQueryController;
    queryViewController.view.frame = frame;
    
    _queryViewController = queryViewController;
    [queryViewController didMoveToParentViewController:self];
}

- (AdvancedQueryViewController *)advancedQueryViewController
{
    if (!_advancedQueryViewController)
    {
        _advancedQueryViewController = [[AdvancedQueryViewController alloc] initWithNibName:@"AdvancedQueryViewController" bundle:nil];
    }
    return _advancedQueryViewController;
}

- (BasicQueryViewController *)basicQueryViewController 
{
    if (!_basicQueryViewController) 
    {
        _basicQueryViewController = [[BasicQueryViewController alloc] initWithNibName:@"BasicQueryViewController" bundle:nil];
    }
    return _basicQueryViewController;
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    self.queryViewController = self.advancedQueryViewController;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)queryTypeChanged:(UISegmentedControl *)sender
{
    QueryViewController *queryViewController = nil;
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            queryViewController = self.advancedQueryViewController;
            break;
        case 1:
            queryViewController = self.basicQueryViewController;
            break;
    }
    
    self.queryViewController = queryViewController;
}

- (IBAction)libraryChoice:(UIBarButtonItem *)sender
{
    if (!self.libraryChoicePopover)
    {
        LibraryChoiceViewController *viewController = [[LibraryChoiceViewController alloc] initWithStyle:UITableViewStylePlain];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        self.libraryChoicePopover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    }
    
    [self.libraryChoicePopover presentPopoverFromBarButtonItem:sender
                                      permittedArrowDirections:UIPopoverArrowDirectionAny
                                                      animated:YES];
    self.libraryChoicePopover.passthroughViews = [NSArray array];
}

@end
