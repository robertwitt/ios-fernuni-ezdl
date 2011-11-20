//
//  QueryResultViewController.m
//  ezDL
//
//  Created by Robert Witt on 20.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultViewController.h"
#import "QueryController.h"


@interface QueryResultViewController ()

@property (nonatomic, strong) UIPopoverController *editQueryPopover;
@property (nonatomic, strong) id<Query> editedQuery;

- (void)prepareForEditQuerySegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForQueryExecutionSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end


@implementation QueryResultViewController

static NSString *SegueIdentifierEditQuery = @"EditQuerySegue";
static NSString *SegueIdentifierQueryExecution = @"QueryExecutionSegue";

@synthesize queryResult = _queryResult;
@synthesize editQueryPopover = _editQueryPopover;
@synthesize editedQuery = _editedQuery;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark Managing the View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
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
    
    return cell;
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

@end
