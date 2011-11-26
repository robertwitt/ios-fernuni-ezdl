//
//  DocumentDetailViewController.m
//  ezDL
//
//  Created by Robert Witt on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DocumentDetailViewController.h"
#import "Author.h"


@interface DocumentDetailViewController ()

@property (nonatomic) NSInteger numberOfSections;
@property (nonatomic) NSInteger documentTitleSection;
@property (nonatomic) NSInteger documentYearSection;
@property (nonatomic) NSInteger documentAuthorsSection;
@property (nonatomic) NSInteger documentAbstractSection;
@property (nonatomic) NSInteger documentLinksSection;

- (UITableViewCell *)basicCell;
- (UITableViewCell *)documentAuthorCellForRow:(NSInteger)row;
- (UITableViewCell *)documentAbstractCell;
- (UITableViewCell *)documentLinkCellForRow:(NSInteger)row;

@end


@implementation DocumentDetailViewController

@synthesize displayedDocument = _displayedDocument;
@synthesize delegate = _delegate;
@synthesize numberOfSections = _numberOfSections;
@synthesize documentTitleSection =_documentTitleSection;
@synthesize documentYearSection = _documentYearSection;
@synthesize documentAuthorsSection = _documentAuthorsSection;
@synthesize documentAbstractSection = _documentAbstractSection;
@synthesize documentLinksSection = _documentLinksSection;

#pragma mark Managing the View

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)setDisplayedDocument:(Document *)displayedDocument
{
    _displayedDocument = displayedDocument;
    
    self.numberOfSections = 0;
    self.documentTitleSection = -1;
    self.documentYearSection = -1;
    self.documentAuthorsSection = -1;
    self.documentAbstractSection = -1;
    self.documentLinksSection = -1;
    
    if (!displayedDocument.title.nilOrEmpty)
    {
        self.documentTitleSection = self.numberOfSections;
        self.numberOfSections++;
    }
    
    if (!displayedDocument.year.nilOrEmpty)
    {
        self.documentYearSection = self.numberOfSections;
        self.numberOfSections++;
    }
    
    if (displayedDocument.authors && displayedDocument.authors.count > 0)
    {
        self.documentAuthorsSection = self.numberOfSections;
        self.numberOfSections++;
    }
    
    if (!displayedDocument.detail.abstract.nilOrEmpty)
    {
        self.documentAbstractSection = self.numberOfSections;
        self.numberOfSections++;
    }
    
    if (displayedDocument.detail.links && displayedDocument.detail.links.count > 0)
    {
        self.documentLinksSection = self.numberOfSections;
        self.numberOfSections++;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows;
    
    if (section == self.documentTitleSection) numberOfRows = 1;
    if (section == self.documentYearSection) numberOfRows = 1;
    if (section == self.documentAuthorsSection) numberOfRows = self.displayedDocument.authors.count;
    if (section == self.documentAbstractSection) numberOfRows = 1;
    if (section == self.documentLinksSection) numberOfRows = self.displayedDocument.detail.links.count;
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == self.documentTitleSection)
    {
        cell = [self basicCell];
        cell.textLabel.text = self.displayedDocument.title;
    }
    
    if (indexPath.section == self.documentYearSection)
    {
        cell = [self basicCell];
        cell.textLabel.text = self.displayedDocument.year;
    }
    
    if (indexPath.section == self.documentAuthorsSection) cell = [self documentAuthorCellForRow:indexPath.row];
    if (indexPath.section == self.documentAbstractSection) cell = [self documentAbstractCell];
    if (indexPath.section == self.documentLinksSection) cell = [self documentLinkCellForRow:indexPath.row];
    
    return cell;
}

- (UITableViewCell *)basicCell
{
    return [self.tableView dequeueReusableCellWithIdentifier:@"BasicCell"];
}

- (UITableViewCell *)documentAuthorCellForRow:(NSInteger)row
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DocumentAuthorCell"];
    Author *author = [self.displayedDocument.authors objectAtIndex:row];
    cell.textLabel.text = author.fullName;
    return cell;
}

- (UITableViewCell *)documentAbstractCell
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DocumentAbstractCell"];
    UITextView *abstractView = (UITextView *)[cell viewWithTag:1];
    abstractView.text = self.displayedDocument.detail.abstract;
    return cell;
}

- (UITableViewCell *)documentLinkCellForRow:(NSInteger)row
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DocumentLinkCell"];
    NSURL *link = [self.displayedDocument.detail.links objectAtIndex:row];
    cell.textLabel.text = link.absoluteString;
    return cell;
}

@end
