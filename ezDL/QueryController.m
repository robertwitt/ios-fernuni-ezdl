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

- (void)startObservingQueryViewController:(QueryViewController *)viewController;
- (void)stopObservingQueryViewController:(QueryViewController *)viewController;

@end


@implementation QueryController

@synthesize clearButton = _clearButton;
@synthesize searchButton = _searchButton;
@synthesize queryViewController = _queryViewController;
@synthesize advancedQueryViewController = _advancedQueryViewController;
@synthesize query = _query;
@synthesize delegate = _delegate;
@synthesize basicQueryViewController = _basicQueryViewController;
@synthesize libraryChoicePopover = _libraryChoicePopover;

#pragma mark Implementing this Controller as Container Controller

- (void)setQueryViewController:(QueryViewController *)queryViewController 
{
    // Remove the old query view controller from its super view controller
    [_queryViewController.view removeFromSuperview];
    [_queryViewController removeFromParentViewController];
    
    // Remove self as observer of old view controller
    [self stopObservingQueryViewController:_queryViewController];
    
    // Add new view controller as child
    [queryViewController willMoveToParentViewController:self];
    [self addChildViewController:queryViewController];
    [self.view addSubview:queryViewController.view];
    
    // Add self as observer of new view controller
    [self startObservingQueryViewController:queryViewController];
    
    // Set view's frame
    CGRect frame;
    frame.origin.x = 20.0f;
    frame.origin.y = 71.0f;
    frame.size = queryViewController.contentSizeForViewInQueryController;
    queryViewController.view.frame = frame;
    
    _queryViewController = queryViewController;
    [queryViewController didMoveToParentViewController:self];
}

- (void)startObservingQueryViewController:(QueryViewController *)viewController
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(queryViewGotFilled)
                                                 name:QueryViewGotFilledNotification
                                               object:viewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(queryViewGotCleared)
                                                 name:QueryViewGotClearedNotification
                                               object:viewController];
}

- (void)queryViewGotFilled
{
    self.clearButton.enabled = YES;
    self.searchButton.enabled = YES;
}

- (void)queryViewGotCleared
{
    self.clearButton.enabled = NO;
    self.searchButton.enabled = NO;
}

- (void)stopObservingQueryViewController:(QueryViewController *)viewController
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:QueryViewGotFilledNotification
                                                  object:viewController];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:QueryViewGotClearedNotification
                                                  object:viewController];
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

#pragma mark Managing the View

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = YES;
    
    self.queryViewController = self.advancedQueryViewController;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
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

- (IBAction)clear
{
    [self.queryViewController clearQueryView];
}

- (IBAction)search
{

}

@end
