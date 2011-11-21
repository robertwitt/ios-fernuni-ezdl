//
//  QueryResultViewController.m
//  ezDL
//
//  Created by Robert Witt on 20.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultViewController.h"
#import "QueryController.h"
#import "QueryResultContent.h"


@interface QueryResultViewController ()

@property (nonatomic, weak) UIPopoverController *editQueryPopover;
@property (nonatomic, weak) UIPopoverController *sortByPopover;
@property (nonatomic, weak) UIPopoverController *groupByPopover;
@property (nonatomic, strong) id<Query> editedQuery;
@property (nonatomic, strong) QueryResultSorting *currentSorting;
@property (nonatomic, strong) QueryResultGrouping *currentGrouping;
@property (nonatomic, strong) QueryResultContent *tableContent;

- (void)prepareForEditQuerySegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForQueryExecutionSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForSortBySegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForGroupBySegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end


@implementation QueryResultViewController

static NSString *SegueIdentifierEditQuery = @"EditQuerySegue";
static NSString *SegueIdentifierQueryExecution = @"QueryExecutionSegue";
static NSString *SegueIdentifierSortBy = @"SortBySegue";
static NSString *SegueIdentifierGroupBy = @"GroupBySegue";

@synthesize sortByItem = _sortByItem;
@synthesize groupByItem = _groupByItem;
@synthesize queryResult = _queryResult;
@synthesize editQueryPopover = _editQueryPopover;
@synthesize sortByPopover = _sortByPopover;
@synthesize groupByPopover = _groupByPopover;
@synthesize editedQuery = _editedQuery;
@synthesize currentSorting = _currentSorting;
@synthesize currentGrouping = _currentGrouping;
@synthesize tableContent = _tableContent;

#pragma mark Managing the View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)setQueryResult:(QueryResult *)queryResult
{
    _queryResult = queryResult;
    
    self.tableContent = [QueryResultContent queryResultContentWithQueryResult:queryResult];
    self.tableContent.sorting = self.currentSorting;
    self.tableContent.grouping = self.currentGrouping;
}

- (QueryResultSorting *)currentSorting
{
    if (!_currentSorting)
    {
        _currentSorting = [QueryResultSorting queryResultSortingWithCriterionType:QueryResultSortingCriterionTypeRelevance
                                                                    directionType:QueryResultSortingDirectionTypeDescending];
    }
    return _currentSorting;
}

- (QueryResultGrouping *)currentGrouping
{
    if (!_currentGrouping) _currentGrouping = [QueryResultGrouping nothingGrouping];
    return _currentGrouping;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.tableContent.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableContent rowsInSectionAtIndex:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QueryResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    QueryResultRow *row = [self.tableContent rowAtIndexPath:indexPath];
    cell.textLabel.text = row.documentTitle;
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.tableContent sectionAtIndex:section];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SegueIdentifierEditQuery])
    {
        [self prepareForEditQuerySegue:segue sender:sender];
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierQueryExecution])
    {
        [self prepareForQueryExecutionSegue:segue sender:sender];
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierSortBy])
    {
        [self prepareForSortBySegue:segue sender:sender];
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierGroupBy])
    {
        [self prepareForGroupBySegue:segue sender:sender];
    }
}

#pragma mark Editing Query

- (IBAction)editQuery:(UIBarButtonItem *)sender
{
    if (self.editQueryPopover.popoverVisible)
    {
        [self.editQueryPopover dismissPopoverAnimated:YES];
    }
    else
    {
        [self performSegueWithIdentifier:SegueIdentifierEditQuery sender:sender];
    }
}

- (void)prepareForEditQuerySegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    QueryController *queryController = segue.destinationViewController;
    queryController.query = self.queryResult.query;
    queryController.delegate = self;
    
    self.editQueryPopover = ((UIStoryboardPopoverSegue *)segue).popoverController;
}

- (BOOL)queryController:(QueryController *)queryController shouldExecuteQuery:(id<Query>)query
{
    [self.editQueryPopover dismissPopoverAnimated:NO];
    
    self.editedQuery = query;
    [self performSegueWithIdentifier:SegueIdentifierQueryExecution sender:self];
    
    return NO;
}

- (void)prepareForQueryExecutionSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QueryExecutionViewController *viewController = segue.destinationViewController;
    viewController.queryToExecute = self.editedQuery;
    viewController.delegate = self;
}

- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didCancelExecutingQuery:(id<Query>)query
{
    [queryExecutionViewController dismissModalViewControllerAnimated:YES];
}

- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didExecuteQueryWithQueryResult:(QueryResult *)queryResult
{
    self.queryResult = queryResult;
    
    [queryExecutionViewController dismissViewControllerAnimated:YES completion:^{
        // TODO Update table view
    }];
}

- (void)queryExecutionViewController:(QueryExecutionViewController *)queryExecutionViewController didFailExecutingQuery:(id<Query>)query withError:(NSError *)error
{    
    id __block myself = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [myself showSimpleAlertWithTitle:NSLocalizedString(@"Error Occured", nil)
                                 message:error.localizedDescription
                                     tag:0];
    }];
}

#pragma mark Sorting the Query Result

- (IBAction)sortBy:(UIBarButtonItem *)sender
{
    if (self.sortByPopover.popoverVisible)
    {
        [self.sortByPopover dismissPopoverAnimated:YES];
    }
    else
    {
        [self performSegueWithIdentifier:SegueIdentifierSortBy sender:sender];
    }
}

- (void)prepareForSortBySegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QueryResultSortingViewController *viewController = segue.destinationViewController;
    
    // TODO Assign current sorting
    
    viewController.delegate = self;
    
    self.sortByPopover = ((UIStoryboardPopoverSegue *)segue).popoverController;
}

- (void)queryResultSortingViewController:(QueryResultSortingViewController *)viewController didSelectSorting:(QueryResultSorting *)sorting
{
    // TODO Implementation needed
}

#pragma mark Grouping the Query Result

- (IBAction)groupByItem:(UIBarButtonItem *)sender
{
    if (self.groupByPopover.popoverVisible)
    {
        [self.groupByPopover dismissPopoverAnimated:YES];
    }
    else
    {
        [self performSegueWithIdentifier:SegueIdentifierGroupBy sender:sender];
    }
}

- (void)prepareForGroupBySegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QueryResultGroupingViewController *viewController = segue.destinationViewController;
    
    // TODO Assign current grouping
    
    viewController.delegate = self;
    
    self.groupByPopover = ((UIStoryboardPopoverSegue *)segue).popoverController;
}

- (void)queryResultGroupingViewController:(QueryResultGroupingViewController *)viewController didSelectGrouping:(QueryResultGrouping *)grouping
{
    
}

@end
