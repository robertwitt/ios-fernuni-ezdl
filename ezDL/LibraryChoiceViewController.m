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

- (IBAction)refreshLibraries;
- (void)selectAllLibraries;
- (void)deselectAllLibraries;
- (void)configureNavigationBar;
- (void)loadLibrariesFromBackend:(BOOL)loadFromBackend;

@end


@implementation LibraryChoiceViewController

@synthesize selectAllItem = _selectAllItem;
@synthesize deselectAllItem = _deselectAllItem;
@synthesize libraryService = _libraryService;
@synthesize currentLibraryChoice = _currentLibraryChoice;

#pragma mark Managing the View

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationBar];
}

- (void)configureNavigationBar {    
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

- (void)viewDidUnload {
    self.selectAllItem = nil;
    self.deselectAllItem = nil;
    _libraryService = nil;
    self.currentLibraryChoice = nil;
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadLibrariesFromBackend:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.libraryService saveLibraryChoice:self.currentLibraryChoice];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (CGSize)contentSizeForViewInPopover {
    return CGSizeMake(680.0f, 440.0f);
}

- (void)setCurrentLibraryChoice:(MutableLibraryChoice *)currentLibraryChoice {
    if (_currentLibraryChoice != currentLibraryChoice) {
        _currentLibraryChoice = currentLibraryChoice;
        if (self.tableView.window) [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentLibraryChoice.allLibraries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LibrarySelectionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell and set library name and description
    Library *library = [self.currentLibraryChoice.allLibraries objectAtIndex:indexPath.row];
    cell.textLabel.text = library.name;
    cell.detailTextLabel.text = library.shortText;
    
    // Ask library choice model if library is already selected
    if ([self.currentLibraryChoice isLibrarySelected:library]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark Loading Libraries by Model

- (id<LibraryService>)libraryService {
    if (!_libraryService) _libraryService = [[ServiceFactory sharedFactory] libraryService];
    return _libraryService;
}

- (IBAction)refreshLibraries {    
    // Execute operation on separate thread to load libraries from backend
    [self loadLibrariesFromBackend:YES];
}

- (UIBarButtonItem *)loadingItem {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator startAnimating];
    UIBarButtonItem *loadingItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    
    return loadingItem;
}

- (void)loadLibrariesFromBackend:(BOOL)loadFromBackend
{
    [self startNetworkActivity];
    UIBarButtonItem *refreshItem = self.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItem = self.loadingItem;
    
    dispatch_queue_t loadingQueue = dispatch_queue_create("de.feu.informatik.mmia.ezdl", NULL);
    dispatch_async(loadingQueue, ^{
        NSError *error = nil;
        LibraryChoice *libraryChoice = [self.libraryService loadLibraryChoiceFromBackend:loadFromBackend
                                                                               withError:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopNetworkActivity];
            self.navigationItem.leftBarButtonItem = refreshItem;
            self.currentLibraryChoice = [[MutableLibraryChoice alloc] initWithLibraryChoice:libraryChoice];
            
            if (error)
            {
                [self showSimpleAlertWithTitle:NSLocalizedString(@"Error Occured", nil) 
                                       message:error.localizedDescription
                                           tag:0];
            }
        });
    });
    
    dispatch_release(loadingQueue);
}

#pragma mark Managing (De)selection of Libraries

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (void)selectAllLibraries {
    [self.currentLibraryChoice selectAllLibraries];
    [self.tableView reloadData];
}

- (void)deselectAllLibraries {
    [self.currentLibraryChoice deselectAllLibraries];
    [self.tableView reloadData];
}

@end
