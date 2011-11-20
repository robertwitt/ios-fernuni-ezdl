//
//  LibraryChoiceViewController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface LibraryChoiceViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UIBarButtonItem *refreshItem;

- (IBAction)refreshLibraries;
- (void)selectAllLibraries;
- (void)deselectAllLibraries;

@end
