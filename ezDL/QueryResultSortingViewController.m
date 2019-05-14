//
//  QueryResultSortingViewController.m
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultSortingViewController.h"


@interface QueryResultSortingViewController ()

@property (nonatomic, strong, readonly) NSArray *sortingCriteria;
@property (nonatomic, strong, readonly) NSArray *sortingDirections;

- (void)configureSortingCriterionCell:(UITableViewCell *)cell atRow:(NSInteger)row;
- (void)configureSortingDirectionCell:(UITableViewCell *)cell atRow:(NSInteger)row;
- (QueryResultSorting *)sortingAfterSelectionAtIndexPath:(NSIndexPath *)indexPath;

@end


@implementation QueryResultSortingViewController

const NSInteger SectionCriteria = 0;
const NSInteger SectionDirections = 1;

@synthesize currentSorting = _currentSorting;
@synthesize delegate = _delegate;
@synthesize sortingCriteria = _sortingCriteria;
@synthesize sortingDirections = _sortingDirections;

#pragma mark Managing the View

- (void)viewDidUnload {
    self.currentSorting = nil;
    self.delegate = nil;
    _sortingCriteria = nil;
    _sortingDirections = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (CGSize)contentSizeForViewInPopover {
    return CGSizeMake(240.0f, 310.0f);
}

- (NSArray *)sortingCriteria {
    if (!_sortingCriteria) {
        _sortingCriteria = [NSArray arrayWithObjects:[QueryResultSortingCriterion authorSortingCriterion], [QueryResultSortingCriterion titleSortingCriterion], [QueryResultSortingCriterion yearSortingCriterion], [QueryResultSortingCriterion relevanceSortingCriterion], nil];
    }
    return _sortingCriteria;
}

- (NSArray *)sortingDirections {
    if (!_sortingDirections) {
        _sortingDirections = [NSArray arrayWithObjects:[QueryResultSortingDirection ascendingSortingDirection], [QueryResultSortingDirection descendingSortingDirection], nil];
    }
    return _sortingDirections;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger numberOfRows = 0;
    switch (section) {
        case SectionCriteria:
            numberOfRows = self.sortingCriteria.count;
            break;
        case SectionDirections:
            numberOfRows = self.sortingDirections.count;
            break;
    }    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SortByCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    switch (indexPath.section) {
        case SectionCriteria:
            [self configureSortingCriterionCell:cell atRow:indexPath.row];
            break;
        case SectionDirections:
            [self configureSortingDirectionCell:cell atRow:indexPath.row];
            break;
    }
    
    return cell;
}

- (void)configureSortingCriterionCell:(UITableViewCell *)cell atRow:(NSInteger)row {
    QueryResultSortingCriterion *criterion = [self.sortingCriteria objectAtIndex:row];
    cell.textLabel.text = criterion.localizedShortText;
    
    if ([criterion isEqual:self.currentSorting.criterion]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)configureSortingDirectionCell:(UITableViewCell *)cell atRow:(NSInteger)row {
    QueryResultSortingDirection *direction = [self.sortingDirections objectAtIndex:row];
    cell.textLabel.text = direction.localizedShortText;
    
    if ([direction isEqual:self.currentSorting.direction]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

#pragma mark Changing the Selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QueryResultSorting *newSorting = [self sortingAfterSelectionAtIndexPath:indexPath];
    
    if (![self.currentSorting isEqual:newSorting]) {
        self.currentSorting = newSorting;
        [self.tableView reloadData];
        [self.delegate queryResultSortingViewController:self didSelectSorting:self.currentSorting];
    }
}

- (QueryResultSorting *)sortingAfterSelectionAtIndexPath:(NSIndexPath *)indexPath {
    QueryResultSortingCriterion *criterion = self.currentSorting.criterion;
    QueryResultSortingDirection *direction = self.currentSorting.direction;
    
    switch (indexPath.section) {
        case SectionCriteria:
            criterion = [self.sortingCriteria objectAtIndex:indexPath.row];
            break;
        case SectionDirections:
            direction = [self.sortingDirections objectAtIndex:indexPath.row];
            break;
    }
    
    return [QueryResultSorting queryResultSortingWithCriterion:criterion direction:direction];
}

@end
