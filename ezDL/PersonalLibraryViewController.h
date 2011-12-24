//
//  PersonalLibraryViewController.h
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroupsViewController.h"
#import "DocumentDetailViewController.h"

@interface PersonalLibraryViewController : UITableViewController <UISearchBarDelegate, PersonalLibraryGroupsViewControllerDelegate, DocumentDetailViewControllerDelegate>

- (IBAction)openGroups:(UIBarButtonItem *)sender;

@end
