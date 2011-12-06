//
//  PersonalLibraryGroupsViewController.m
//  ezDL
//
//  Created by Robert Witt on 06.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroupsViewController.h"

@implementation PersonalLibraryGroupsViewController

@synthesize selectedGroups = _selectedGroups;
@synthesize delegate = _delegate;

#pragma mark Managing the View

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell"];
    
    // Configure the cell...
    
    return cell;
}

@end
