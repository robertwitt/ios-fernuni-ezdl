//
//  DocumentDetailViewController.m
//  ezDL
//
//  Created by Robert Witt on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DocumentDetailViewController.h"
#import "QueryController.h"
#import "ServiceFactory.h"


@interface DocumentDetailViewController () <DocumentLinkViewControllerDelegate, PersonalLibraryReferenceAddViewControllerDelegate>

@property (nonatomic, strong) UIBarButtonItem *previousItem;
@property (nonatomic, strong) UIBarButtonItem *nextItem;
@property (nonatomic) NSInteger numberOfDocuments;
@property (nonatomic) NSInteger documentIndex;
@property (nonatomic) NSInteger numberOfSections;
@property (nonatomic) NSInteger documentTitleSection;
@property (nonatomic) NSInteger documentYearSection;
@property (nonatomic) NSInteger documentAuthorsSection;
@property (nonatomic) NSInteger documentAbstractSection;
@property (nonatomic) NSInteger documentLinksSection;
@property (nonatomic, strong) NSError *loadingError;

- (void)configureNavigationBar;
- (void)didChangeDocument;
- (UITableViewCell *)basicCell;
- (UITableViewCell *)documentAuthorCellForRow:(NSInteger)row;
- (UITableViewCell *)documentAbstractCell;
- (UITableViewCell *)documentLinkCellForRow:(NSInteger)row;
- (void)startLoadingOperation;
- (void)loadDocumentDetails;
- (void)loadingDocumentDetailsFinished;
- (void)previousDocument;
- (void)nextDocument;
- (void)prepareForQueryFromAuthorSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (Query *)buildQueryWithAuthor:(Author *)author;
- (void)prepareForDocumentLinkSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)prepareForAddReferenceSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end


@implementation DocumentDetailViewController

static NSString *SegueQueryFromAuthor = @"QueryFromAuthorSegue";
static NSString *SegueDocumentLink = @"DocumentLinkSegue";
static NSString *SegueAddReference = @"AddReferenceSegue";

@synthesize previousItem = _previousItem;
@synthesize nextItem = _nextItem;
@synthesize numberOfDocuments = _numberOfDocuments;
@synthesize documentIndex = _documentIndex;
@synthesize displayedDocument = _displayedDocument;
@synthesize hideAddReferenceItem = _hideAddReferenceItem;
@synthesize delegate = _delegate;
@synthesize numberOfSections = _numberOfSections;
@synthesize documentTitleSection =_documentTitleSection;
@synthesize documentYearSection = _documentYearSection;
@synthesize documentAuthorsSection = _documentAuthorsSection;
@synthesize documentAbstractSection = _documentAbstractSection;
@synthesize documentLinksSection = _documentLinksSection;
@synthesize loadingError = _loadingError;

#pragma mark Managing the View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // If the delegate is set, show a stepper in right area of navigation bar to iterate to query result collection
    if (self.delegate) [self configureNavigationBar];
}

- (void)configureNavigationBar {
    self.previousItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Previous", nil)
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self
                                                        action:@selector(previousDocument)];
    self.nextItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil)
                                                     style:UIBarButtonItemStyleBordered
                                                    target:self 
                                                    action:@selector(nextDocument)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.nextItem, self.previousItem, nil];
    
    self.numberOfDocuments = [self.delegate documentDetailViewControllerNumberOfDocuments:self];
    self.documentIndex = [self.delegate documentDetailViewController:self indexOfDocument:self.displayedDocument];
}

- (void)viewDidUnload {
    self.displayedDocument = nil;
    self.delegate = nil;
    self.loadingError = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = self.hideAddReferenceItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startLoadingOperation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)setDisplayedDocument:(Document *)displayedDocument {    
    _displayedDocument = displayedDocument;
    
    self.title = displayedDocument.title;
    
    self.numberOfSections = 0;
    self.documentTitleSection = -1;
    self.documentYearSection = -1;
    self.documentAuthorsSection = -1;
    self.documentAbstractSection = -1;
    self.documentLinksSection = -1;
    
    if (displayedDocument.title.notEmpty) {
        self.documentTitleSection = self.numberOfSections;
        self.numberOfSections++;
    }
    
    if (displayedDocument.year.notEmpty) {
        self.documentYearSection = self.numberOfSections;
        self.numberOfSections++;
    }
    
    if (displayedDocument.authors && displayedDocument.authors.count > 0) {
        self.documentAuthorsSection = self.numberOfSections;
        self.numberOfSections++;
    }
    
    if (displayedDocument.detail) {
        if (displayedDocument.detail.abstract.notEmpty) {
            self.documentAbstractSection = self.numberOfSections;
            self.numberOfSections++;
        }
        
        if (displayedDocument.detail.links && displayedDocument.detail.links.count > 0) {
            self.documentLinksSection = self.numberOfSections;
            self.numberOfSections++;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    
    if (section == self.documentTitleSection) numberOfRows = 1;
    if (section == self.documentYearSection) numberOfRows = 1;
    if (section == self.documentAuthorsSection) numberOfRows = self.displayedDocument.authors.count;
    if (section == self.documentAbstractSection) numberOfRows = 1;
    if (section == self.documentLinksSection) numberOfRows = self.displayedDocument.detail.links.count;
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (indexPath.section == self.documentTitleSection) {
        cell = [self basicCell];
        cell.textLabel.text = self.displayedDocument.title;
    }
    
    if (indexPath.section == self.documentYearSection) {
        cell = [self basicCell];
        cell.textLabel.text = self.displayedDocument.year;
    }
    
    if (indexPath.section == self.documentAuthorsSection) cell = [self documentAuthorCellForRow:indexPath.row];
    if (indexPath.section == self.documentAbstractSection) cell = [self documentAbstractCell];
    if (indexPath.section == self.documentLinksSection) cell = [self documentLinkCellForRow:indexPath.row];
    
    return cell;
}

- (UITableViewCell *)basicCell {
    return [self.tableView dequeueReusableCellWithIdentifier:@"BasicCell"];
}

- (UITableViewCell *)documentAuthorCellForRow:(NSInteger)row {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DocumentAuthorCell"];
    Author *author = [self.displayedDocument.authors.allObjects objectAtIndex:row];
    cell.textLabel.text = author.fullName;
    return cell;
}

- (UITableViewCell *)documentAbstractCell {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DocumentAbstractCell"];
    UITextView *abstractView = (UITextView *)[cell viewWithTag:1];
    abstractView.text = self.displayedDocument.detail.abstract;
    return cell;
}

- (UITableViewCell *)documentLinkCellForRow:(NSInteger)row {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DocumentLinkCell"];
    DocumentLink *link = [self.displayedDocument.detail.links.allObjects objectAtIndex:row];
    cell.textLabel.text = link.urlString;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    
    if (section == self.documentTitleSection) title = NSLocalizedString(@"Title", nil);
    if (section == self.documentYearSection) title = NSLocalizedString(@"Year", nil);
    if (section == self.documentAuthorsSection) title = NSLocalizedString(@"Authors", nil);
    if (section == self.documentAbstractSection) title = NSLocalizedString(@"Abstract", nil);
    if (section == self.documentLinksSection) title = NSLocalizedString(@"Links", nil);
    
    return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.0f;
    if (indexPath.section == self.documentAbstractSection) height = 200.0f;
    return height;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SegueQueryFromAuthor]) {
        [self prepareForQueryFromAuthorSegue:segue sender:sender];
    }
    
    if ([segue.identifier isEqualToString:SegueDocumentLink]) {
        [self prepareForDocumentLinkSegue:segue sender:sender];
    }
    
    if ([segue.identifier isEqualToString:SegueAddReference]) {
        [self prepareForAddReferenceSegue:segue sender:sender];
    }
}

#pragma mark Loading Document Details from Backend

- (void)startLoadingOperation {
    if (!self.displayedDocument.detail) {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            [self startNetworkActivity];
            [self loadDocumentDetails];
        }];
        
        [operation setCompletionBlock:^{
            [self loadingDocumentDetailsFinished];
        }];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperation:operation];
    }
}

- (void)loadDocumentDetails {
    NSError *error = nil;
    [[[ServiceFactory sharedFactory] documentService] loadDocumentDetailInDocument:self.displayedDocument
                                                                         withError:&error];
    self.loadingError = error;
    self.displayedDocument = self.displayedDocument;
}

- (void)loadingDocumentDetailsFinished {
    NSBlockOperation *finishedOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self.tableView reloadData];
        [self stopNetworkActivity];
        
        NSError *error = self.loadingError;
        if (error)
        {
            [self showSimpleAlertWithTitle:NSLocalizedString(@"Error Occured", nil)
                                   message:error.localizedDescription
                                       tag:0];
        }
    }];
    
    [[NSOperationQueue mainQueue] addOperation:finishedOperation];
}

#pragma mark Switching between Documents

- (void)setDocumentIndex:(NSInteger)documentIndex {
    _documentIndex = documentIndex;
    
    self.previousItem.enabled = (documentIndex != 0);
    self.nextItem.enabled = (documentIndex != (self.numberOfDocuments - 1));
}

- (void)previousDocument {
    self.documentIndex--;
    [self didChangeDocument];
}

- (void)nextDocument {
    self.documentIndex++;
    [self didChangeDocument];
}

- (void)didChangeDocument {
    self.displayedDocument = [self.delegate documentDetailViewController:self documentAtIndex:self.documentIndex];
    [self.tableView reloadData];
    [self startLoadingOperation];
}

#pragma mark Executing Query from Author

- (void)prepareForQueryFromAuthorSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
    Author *selectedAuthor = [self.displayedDocument.authors.allObjects objectAtIndex:indexPath.row];
    QueryController *queryController = (QueryController *)segue.destinationViewController;
    queryController.query = [self buildQueryWithAuthor:selectedAuthor];
}

- (Query *)buildQueryWithAuthor:(Author *)author {
    NSString *authorName = [NSString stringWithFormat:@"\"%@\"", author.fullName];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:authorName forKey:kQueryParameterKeyAuthor];
    return [[[ServiceFactory sharedFactory] queryService] buildQueryFromParameters:parameters];
}

#pragma mark Showing Document Link

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.documentLinksSection) {
        [self performSegueWithIdentifier:SegueDocumentLink sender:[self.tableView cellForRowAtIndexPath:indexPath]];
    }
}

- (void)prepareForDocumentLinkSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    DocumentLink *selectedLink = [self.displayedDocument.detail.links.allObjects objectAtIndex:indexPath.row];
    DocumentLinkViewController *viewController = (DocumentLinkViewController *)segue.destinationViewController;
    viewController.displayedLink = selectedLink.url;
    viewController.delegate = self;
}

- (void)doneWithdocumentLinkViewController:(DocumentLinkViewController *)viewController {
    [viewController dismissModalViewControllerAnimated:YES];
}

#pragma mark Adding the Document as Reference to Personal Library

- (void)prepareForAddReferenceSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PersonalLibraryReferenceAddViewController *viewController = (PersonalLibraryReferenceAddViewController *)((UINavigationController *)segue.destinationViewController).topViewController;
    viewController.referenceDocument = self.displayedDocument;
    viewController.delegate = self;
}

- (void)didCancelReferenceAddViewController:(PersonalLibraryReferenceAddViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)referenceAddViewController:(PersonalLibraryReferenceAddViewController *)viewController didSaveReference:(PersonalLibraryReference *)reference {
    [viewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
