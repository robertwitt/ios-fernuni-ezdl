//
//  PersonalLibraryViewController.m
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryViewController.h"
#import "ServiceFactory.h"

// TODO Temporary import
#import "AuthorMO.h"


@interface PersonalLibraryViewController ()

@property (nonatomic, weak, readonly) id<PersonalLibraryService> personalLibraryService;

- (PersonalLibraryGroupMO *)groupInSection:(NSInteger)section;
- (PersonalLibraryReferenceMO *)referenceAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)stringFromAuthors:(NSSet *)authors;

@end


@implementation PersonalLibraryViewController

@synthesize personalLibraryService = _personalLibraryService;

#pragma mark Managing the View

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (id<PersonalLibraryService>)personalLibraryService
{
    if (!_personalLibraryService) _personalLibraryService = [[ServiceFactory sharedFactory] personalLibraryService];
    return _personalLibraryService;
}

- (PersonalLibraryGroupMO *)groupInSection:(NSInteger)section
{
    return [[self.personalLibraryService personalLibraryGroups] objectAtIndex:section];
}

- (PersonalLibraryReferenceMO *)referenceAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalLibraryGroupMO *group = [self groupInSection:indexPath.section];
    NSArray *references = [group.references allObjects];
    return [references objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.personalLibraryService personalLibraryGroups].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self groupInSection:section].references.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReferenceCell"];
    
    PersonalLibraryReferenceMO *reference = [self referenceAtIndexPath:indexPath];
    cell.textLabel.text = reference.document.title;
    cell.detailTextLabel.text = [self stringFromAuthors:reference.document.authors];
    
    return cell;
}

- (NSString *)stringFromAuthors:(NSSet *)authors
{
    NSMutableString *string = [NSMutableString string];
    NSArray *array = [authors allObjects];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        AuthorMO *author = obj;
        if (idx == 0) [string appendString:author.fullName];
        else [string appendFormat:@"; %@", author.fullName];
    }];
    return string;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self groupInSection:section].name;
}

@end
