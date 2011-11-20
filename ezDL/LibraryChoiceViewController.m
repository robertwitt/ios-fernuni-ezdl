//
//  LibraryChoiceViewController.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryChoiceViewController.h"
#import "LibraryService.h"
#import "MutableLibraryChoice.h"
#import "ServiceFactory.h"


@interface LibraryChoiceViewController ()

@property (nonatomic, strong) UIBarButtonItem *selectAllItem;
@property (nonatomic, strong) UIBarButtonItem *deselectAllItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *loadingItem;
@property (nonatomic, strong, readonly) id<LibraryService> libraryService;
@property (nonatomic, strong) MutableLibraryChoice *currentLibraryChoice;

- (void)configureNavigationBar;
- (void)loadLibrariesFromBackend:(BOOL)loadFromBackend;

@end


@implementation LibraryChoiceViewController

@synthesize refreshItem = _refreshItem;
@synthesize selectAllItem = _selectAllItem;
@synthesize deselectAllItem = _deselectAllItem;
@synthesize loadingItem = _loadingItem;
@synthesize libraryService = _libraryService;
@synthesize currentLibraryChoice = _currentLibraryChoice;

- (id<LibraryService>)libraryService
{
    if (!_libraryService) _libraryService = [[ServiceFactory sharedFactory] libraryService];
    return _libraryService;
}

#pragma mark Managing the View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureNavigationBar];
    
    [self loadLibrariesFromBackend:NO];
}

- (void)configureNavigationBar
{    
    // Add buttons to select/deselect all libraries
    self.selectAllItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Select all", nil)
                                                          style:UIBarButtonItemStyleBordered
                                                         target:self
                                                         action:@selector(selectAllLibraries)];
    
    self.deselectAllItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Deselect all", nil)
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(deselectAllLibraries)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.deselectAllItem, self.selectAllItem, nil];
}

- (void)viewDidUnload
{
    self.refreshItem = nil;
    self.selectAllItem = nil;
    self.deselectAllItem = nil;
    _loadingItem = nil;
    _libraryService = nil;
    self.currentLibraryChoice = nil;
    
    [super viewDidUnload];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.libraryService saveLibraryChoice:self.currentLibraryChoice];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (CGSize)contentSizeForViewInPopover
{
    NSInteger numberOfRows = self.currentLibraryChoice.allLibraries.count;
    if (numberOfRows < 5) numberOfRows = 5;
    
    CGSize size;
    size.width = 680.0f;
    size.height = numberOfRows * 44.0f + 44.0f;
    
    return size;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.currentLibraryChoice.allLibraries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LibrarySelectionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // Configure the cell and set library name and description
    Library *library = [self.currentLibraryChoice.allLibraries objectAtIndex:indexPath.row];
    cell.textLabel.text = library.name;
    cell.detailTextLabel.text = library.shortDescription;
    
    // Ask library choice model if library is already selected
    if ([self.currentLibraryChoice isLibrarySelected:library]) 
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark Loading Libraries by Model

- (IBAction)refreshLibraries
{
    self.navigationItem.leftBarButtonItem = self.loadingItem;
    
    // Execute operation on separated thread to load libraries from backend
    id __block myself = self;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        [myself loadLibrariesFromBackend:YES];
        [[myself navigationItem] setLeftBarButtonItem:[myself refreshItem]];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (UIBarButtonItem *)loadingItem
{
    if (!_loadingItem)
    {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activityIndicator startAnimating];
        _loadingItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    }
    return _loadingItem;
}

- (void)loadLibrariesFromBackend:(BOOL)loadFromBackend
{
    [self startNetworkActivity];
    
    NSError *error = nil;
    LibraryChoice *libraryChoice = [self.libraryService loadLibraryChoiceFromBackend:loadFromBackend
                                                                           withError:&error];
    [self stopNetworkActivity];
    
    if (error)
    {
        [self showSimpleAlertWithTitle:NSLocalizedString(@"Error Occured", nil) 
                               message:error.localizedDescription
                                   tag:0];
    }
    
    self.currentLibraryChoice = [[MutableLibraryChoice alloc] initWithLibraryChoice:libraryChoice];
    [self.tableView reloadData];
}

#pragma mark Managing (De)selection of Libraries

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Library *library = [self.currentLibraryChoice.allLibraries objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (cell.accessoryType) {
        case UITableViewCellAccessoryCheckmark:
            // Library was selected. Deselect it.
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self.currentLibraryChoice deselectLibrary:library];
            break;
            
        case UITableViewCellAccessoryNone:
            // Library was unselected. Select it now.
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.currentLibraryChoice selectLibrary:library];
            break;
            
        default:
            break;
    }
}

- (void)selectAllLibraries
{
    [self.currentLibraryChoice selectAllLibraries];
    [self.tableView reloadData];
}

- (void)deselectAllLibraries
{
    [self.currentLibraryChoice deselectAllLibraries];
    [self.tableView reloadData];
}

@end
