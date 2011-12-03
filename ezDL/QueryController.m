//
//  QueryController.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryController.h"
#import "LibraryChoiceViewController.h"
#import "QueryResultViewController.h"


@interface QueryController ()

@property (nonatomic, strong, readonly) QueryViewController *advancedQueryViewController;
@property (nonatomic, strong, readonly) QueryViewController *basicQueryViewController;
@property (nonatomic, strong) UIPopoverController *libraryChoicePopover;
@property (nonatomic, strong) QueryResult *queryResultAfterExecution;

- (void)startObservingQueryViewController:(QueryViewController *)viewController;
- (void)stopObservingQueryViewController:(QueryViewController *)viewController;
- (void)prepareForLibraryChoiceSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForQueryExecutionSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForQueryResultSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)performSearch;

@end


@implementation QueryController

static NSString *SegueIdentifierLibraryChoice = @"LibraryChoiceSegue";
static NSString *SegueIdentifierQueryExecution = @"QueryExecutionSegue";
static NSString *SegueIdentifierQueryResult = @"QueryResultSegue";

@synthesize clearButton = _clearButton;
@synthesize searchButton = _searchButton;
@synthesize queryViewController = _queryViewController;
@synthesize advancedQueryViewController = _advancedQueryViewController;
@synthesize basicQueryViewController = _basicQueryViewController;
@synthesize query = _query;
@synthesize delegate = _delegate;
@synthesize libraryChoicePopover = _libraryChoicePopover;
@synthesize queryResultAfterExecution = _queryResultAfterExecution;

#pragma mark Managing the View

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    self.queryViewController = self.advancedQueryViewController;
}

- (void)viewDidUnload
{
    self.clearButton = nil;
    self.searchButton = nil;
    self.queryViewController = nil;
    _advancedQueryViewController = nil;
    _basicQueryViewController = nil;
    self.query = nil;
    self.delegate = nil;
    self.libraryChoicePopover = nil;
    self.queryResultAfterExecution = _queryResultAfterExecution;
    
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
    
    [self startObservingQueryViewController:self.queryViewController];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stopObservingQueryViewController:self.queryViewController];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (CGSize)contentSizeForViewInPopover
{
    CGSize size;
    size.width = 600.0f;
    size.height = 400.0f;
    
    return size;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SegueIdentifierLibraryChoice])
    {
        [self prepareForLibraryChoiceSegue:segue sender:sender];
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierQueryExecution])
    {
        [self prepareForQueryExecutionSegue:segue sender:sender];
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierQueryResult])
    {
        [self prepareForQueryResultSegue:segue sender:sender];
    }
}

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(queryViewSearchKeyPressed) 
                                                 name:QueryViewSearchRequestedNotification
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

- (void)queryViewSearchKeyPressed
{
    [self performSearch];
}

- (void)stopObservingQueryViewController:(QueryViewController *)viewController
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:QueryViewGotFilledNotification
                                                  object:viewController];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:QueryViewGotClearedNotification
                                                  object:viewController];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:QueryViewSearchRequestedNotification 
                                                  object:viewController];
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

- (QueryViewController *)advancedQueryViewController
{
    if (!_advancedQueryViewController) _advancedQueryViewController = [QueryViewController advancedQueryViewController];
    return _advancedQueryViewController;
}

- (QueryViewController *)basicQueryViewController
{
    if (!_basicQueryViewController) _basicQueryViewController = [QueryViewController basicQueryViewController];
    return _basicQueryViewController;
}

#pragma mark Clearing the Query View

- (IBAction)clear
{
    [self.queryViewController clearQueryView];
}

#pragma mark Showing and Library Choice as Popover

- (IBAction)libraryChoice:(UIBarButtonItem *)sender
{
    if (self.libraryChoicePopover.popoverVisible)
    {
        [self.libraryChoicePopover dismissPopoverAnimated:YES];
    }
    else
    {
        [self performSegueWithIdentifier:SegueIdentifierLibraryChoice sender:sender];
    }
}

- (void)prepareForLibraryChoiceSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.libraryChoicePopover = ((UIStoryboardPopoverSegue *)segue).popoverController;
    self.libraryChoicePopover.passthroughViews = nil;
}

#pragma mark Executing the Query

- (IBAction)search:(id)sender
{
    [self performSearch];
}

- (void)performSearch
{
    BOOL shouldExecuteQuery = YES;
    
    if ([self.delegate respondsToSelector:@selector(queryController:shouldExecuteQuery:)])
    {
        shouldExecuteQuery = [self.delegate queryController:self
                                         shouldExecuteQuery:[self.queryViewController buildQuery]];
    }
    
    if (shouldExecuteQuery)
    {
        [self performSegueWithIdentifier:SegueIdentifierQueryExecution sender:nil];
    }
}

- (void)prepareForQueryExecutionSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.queryViewController resignFirstResponder];
    
    id<Query> query = [self.queryViewController buildQuery];
    
    QueryExecutionViewController *viewController = segue.destinationViewController;
    viewController.queryToExecute = query;
    viewController.delegate = self;
    
    // Inform delegate that query is about to be executed
    if ([self.delegate respondsToSelector:@selector(queryController:willExecuteQuery:)])
    {
        [self.delegate queryController:self willExecuteQuery:query];
    }
}

- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didCancelExecutingQuery:(id<Query>)query
{
    // User canceled query execution. Dismiss the query execution controller and inform delegate.
    [queryExecutionViewController dismissModalViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(queryController:didCancelExecutingQuery:)])
    {
        [self.delegate queryController:self didCancelExecutingQuery:query];
    }
}

- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didExecuteQueryWithQueryResult:(QueryResult *)queryResult
{
    // Query execution finished with success. Dismiss query execution controller and navigation to query result if hidesQueryResultAfterSearch property is NO.
    
    self.queryResultAfterExecution = queryResult;
    
    if ([self.delegate respondsToSelector:@selector(queryController:didExecuteQueryWithQueryResult:)])
    {
        [self.delegate queryController:self didExecuteQueryWithQueryResult:queryResult];
    }
    
    __weak id weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf performSegueWithIdentifier:SegueIdentifierQueryResult sender:[weakSelf searchButton]];
    }];
}

- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didFailExecutingQuery:(id<Query>)query withError:(NSError *)error
{
    // Dismiss query execution controller, send message to delegate and display error
    
    __weak id weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf showSimpleAlertWithTitle:NSLocalizedString(@"Error Occured", nil)
                                   message:error.localizedDescription
                                       tag:0];
    }];
    
    if ([self.delegate respondsToSelector:@selector(queryController:didFailExecutingQuery:withError:)])
    {
        [self.delegate queryController:self didFailExecutingQuery:query withError:error];
    }
}

#pragma mark Navigating to Query Result View Controller

- (void)prepareForQueryResultSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QueryResultViewController *viewController = segue.destinationViewController;
    viewController.queryResult = self.queryResultAfterExecution;
}

@end
