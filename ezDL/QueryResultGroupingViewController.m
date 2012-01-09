//
//  QueryResultGroupingViewController.m
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultGroupingViewController.h"


@interface QueryResultGroupingViewController ()

@property (nonatomic, strong, readonly) NSArray *groupings;

@end


@implementation QueryResultGroupingViewController

@synthesize currentGrouping = _currentGrouping;
@synthesize delegate = _delegate;
@synthesize groupings = _groupings;

#pragma mark Managing the View

- (void)viewDidUnload {
    self.currentGrouping = nil;
    self.delegate = nil;
    _groupings = nil;
    [self viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (CGSize)contentSizeForViewInPopover {
    return CGSizeMake(240.0f, 195.0f);
}

- (NSArray *)groupings
{
    if (!_groupings) {
        _groupings = [NSArray arrayWithObjects:[QueryResultGrouping nothingGrouping], [QueryResultGrouping decadeGrouping], [QueryResultGrouping libraryGrouping], [QueryResultGrouping authorsGrouping], nil];
    }
    return _groupings;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"GroupByCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    QueryResultGrouping *grouping = [self.groupings objectAtIndex:indexPath.row];
    cell.textLabel.text = grouping.localizedShortText;
    
    if ([grouping isEqual:self.currentGrouping]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark Changing the Selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QueryResultGrouping *newGrouping = [self.groupings objectAtIndex:indexPath.row];
    
    if (![self.currentGrouping isEqual:newGrouping]) {
        self.currentGrouping = newGrouping;
        [self.tableView reloadData];
        
        [self.delegate queryResultGroupingViewController:self didSelectGrouping:self.currentGrouping];
    }
}

@end
