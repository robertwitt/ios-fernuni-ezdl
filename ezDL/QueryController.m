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


@interface QueryController () <QueryExecutionViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl *queryTypeControl;
@property (nonatomic, weak) IBOutlet UIButton *clearButton;
@property (nonatomic, weak) IBOutlet UIButton *searchButton;
@property (nonatomic, strong, readonly) QueryViewController *advancedQueryViewController;
@property (nonatomic, strong, readonly) QueryViewController *basicQueryViewController;
@property (nonatomic, strong) UIPopoverController *libraryChoicePopover;
@property (nonatomic, strong) QueryResult *queryResultAfterExecution;

- (IBAction)queryTypeChanged:(UISegmentedControl *)sender;
- (IBAction)libraryChoice:(UIBarButtonItem *)sender;
- (IBAction)clear;
- (IBAction)search:(id)sender;
- (void)queryViewSearchKeyPressed;
- (void)displayQueryViewControllerInitially;
- (void)startObservingQueryViewController:(QueryViewController *)viewController;
- (void)stopObservingQueryViewController:(QueryViewController *)viewController;
- (void)prepareForLibraryChoiceSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForQueryExecutionSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForQueryResultSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (BOOL)shouldPerformSearch;
- (void)performSearch;

@end


@implementation QueryController

static NSString *SegueIdentifierLibraryChoice = @"LibraryChoiceSegue";
static NSString *SegueIdentifierQueryExecution = @"QueryExecutionSegue";
static NSString *SegueIdentifierQueryResult = @"QueryResultSegue";

@synthesize queryTypeControl = _queryTypeControl;
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

- (void)viewDidUnload {
    self.queryTypeControl = nil;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
    [self displayQueryViewControllerInitially];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopObservingQueryViewController:self.queryViewController];
}

- (void)displayQueryViewControllerInitially {
    // Decide which query view controller is visible at startup by display compatibility of the query
    if ([self.advancedQueryViewController canDisplayQuery:self.query]) {
        self.queryViewController = self.advancedQueryViewController;
        self.queryTypeControl.selectedSegmentIndex = 0;
    } else {
        self.queryViewController = self.basicQueryViewController;
        self.queryTypeControl.selectedSegmentIndex = 1;
    }
    self.queryViewController.query = self.query;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (CGSize)contentSizeForViewInPopover {
    return CGSizeMake(600.0f, 400.0f);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SegueIdentifierLibraryChoice]) {
        [self prepareForLibraryChoiceSegue:segue sender:sender];
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierQueryExecution]) {
        [self prepareForQueryExecutionSegue:segue sender:sender];
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierQueryResult]) {
        [self prepareForQueryResultSegue:segue sender:sender];
    }
}

#pragma mark Implementing this Controller as Container Controller

- (void)setQueryViewController:(QueryViewController *)queryViewController  {
    // Keep the query
    queryViewController.query = [_queryViewController buildQuery];
    
    // Remove the old query view controller from its super view controller
    [_queryViewController.view removeFromSuperview];
    [_queryViewController removeFromParentViewController];
    
    [self stopObservingQueryViewController:_queryViewController];
    
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
    
    [self startObservingQueryViewController:queryViewController]; 
    
    _queryViewController = queryViewController;
    [queryViewController didMoveToParentViewController:self];
}

- (void)startObservingQueryViewController:(QueryViewController *)viewController {
    [self startObservingObject:viewController
              notificationName:QueryViewControllerReturnKeyNotification
                      selector:@selector(queryViewSearchKeyPressed)];
}

- (void)stopObservingQueryViewController:(QueryViewController *)viewController {
    [self stopObservingObject:viewController 
             notificationName:QueryViewControllerReturnKeyNotification];
}

- (void)queryViewSearchKeyPressed {
    if ([self shouldPerformSearch]) [self performSearch];
}

- (IBAction)queryTypeChanged:(UISegmentedControl *)sender {
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
    
    if (![queryViewController canDisplayQuery:queryViewController.query]) {
        [self showSimpleAlertWithTitle:NSLocalizedString(@"Error Occured", nil)
                               message:NSLocalizedString(@"Advanced Query Message", nil)
                                   tag:0];
    }
}

- (QueryViewController *)advancedQueryViewController {
    if (!_advancedQueryViewController) _advancedQueryViewController = [QueryViewController advancedQueryViewController];
    return _advancedQueryViewController;
}

- (QueryViewController *)basicQueryViewController {
    if (!_basicQueryViewController) _basicQueryViewController = [QueryViewController basicQueryViewController];
    return _basicQueryViewController;
}

#pragma mark Clearing the Query View

- (IBAction)clear {
    [self.queryViewController clearQueryView];
}

#pragma mark Showing and Library Choice as Popover

- (IBAction)libraryChoice:(UIBarButtonItem *)sender {
    if (self.libraryChoicePopover.popoverVisible) {
        [self.libraryChoicePopover dismissPopoverAnimated:YES];
    } else {
        [self performSegueWithIdentifier:SegueIdentifierLibraryChoice sender:sender];
    }
}

- (void)prepareForLibraryChoiceSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.libraryChoicePopover = ((UIStoryboardPopoverSegue *)segue).popoverController;
    self.libraryChoicePopover.passthroughViews = nil;
}

#pragma mark Executing the Query

- (IBAction)search:(id)sender {
    if ([self shouldPerformSearch]) [self performSearch];
}

- (BOOL)shouldPerformSearch {
    BOOL should = NO;
    if (![self.queryViewController viewIsEmpty]) {
        should = [self.queryViewController checkQuerySyntax];
        if (!should) {
            [self showSimpleAlertWithTitle:NSLocalizedString(@"Error Occured", nil)
                                   message:NSLocalizedString(@"Syntax Incorrect Message", nil) 
                                       tag:0];
        }
    }
    return should;
}

- (void)performSearch {
    self.query = [self.queryViewController buildQuery];
    
    BOOL shouldExecuteQuery = YES;
    if ([self.delegate respondsToSelector:@selector(queryController:shouldExecuteQuery:)]) {
        shouldExecuteQuery = [self.delegate queryController:self
                                         shouldExecuteQuery:self.query];
    }
    
    if (shouldExecuteQuery) {
        [self performSegueWithIdentifier:SegueIdentifierQueryExecution sender:nil];
    }
}

- (void)prepareForQueryExecutionSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.queryViewController resignFirstResponder];
    
    Query *query = self.query;
    
    QueryExecutionViewController *viewController = segue.destinationViewController;
    viewController.queryToExecute = query;
    viewController.delegate = self;
    
    // Inform delegate that query is about to be executed
    if ([self.delegate respondsToSelector:@selector(queryController:willExecuteQuery:)]) {
        [self.delegate queryController:self willExecuteQuery:query];
    }
}

- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didCancelExecutingQuery:(Query *)query {
    // User canceled query execution. Dismiss the query execution controller and inform delegate.
    [queryExecutionViewController dismissModalViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(queryController:didCancelExecutingQuery:)]) {
        [self.delegate queryController:self didCancelExecutingQuery:query];
    }
}

- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didExecuteQueryWithQueryResult:(QueryResult *)queryResult {
    // Query execution finished with success. Dismiss query execution controller and navigation to query result if hidesQueryResultAfterSearch property is NO.
    
    self.queryResultAfterExecution = queryResult;
    
    if ([self.delegate respondsToSelector:@selector(queryController:didExecuteQueryWithQueryResult:)]) {
        [self.delegate queryController:self didExecuteQueryWithQueryResult:queryResult];
    }
    
    __weak id weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf performSegueWithIdentifier:SegueIdentifierQueryResult sender:[weakSelf searchButton]];
    }];
}

- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didFailExecutingQuery:(Query *)query withError:(NSError *)error {
    // Dismiss query execution controller, send message to delegate and display error
    
    __weak id weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf showSimpleAlertWithTitle:NSLocalizedString(@"Error Occured", nil)
                                   message:error.localizedDescription
                                       tag:0];
    }];
    
    if ([self.delegate respondsToSelector:@selector(queryController:didFailExecutingQuery:withError:)]) {
        [self.delegate queryController:self didFailExecutingQuery:query withError:error];
    }
}

#pragma mark Navigating to Query Result View Controller

- (void)prepareForQueryResultSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QueryResultViewController *viewController = segue.destinationViewController;
    viewController.queryResult = self.queryResultAfterExecution;
}

@end
