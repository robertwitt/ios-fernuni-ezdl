//
//  PersonalLibraryGroupsViewController.h
//  ezDL
//
//  Created by Robert Witt on 06.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class PersonalLibraryGroupsViewController;
@protocol PersonalLibraryGroupsViewControllerDelegate <NSObject>

- (void)groupsViewController:(PersonalLibraryGroupsViewController *)viewController didAddGroup:(PersonalLibraryGroup *)group;
- (void)groupsViewController:(PersonalLibraryGroupsViewController *)viewController didDeleteGroup:(PersonalLibraryGroup *)group;
- (void)groupsViewController:(PersonalLibraryGroupsViewController *)viewController didChangeGroupSelection:(NSArray *)groups;

@end

@interface PersonalLibraryGroupsViewController : UITableViewController

@property (nonatomic, strong) NSArray *selectedGroups;
@property (nonatomic, weak) id<PersonalLibraryGroupsViewControllerDelegate> delegate;

@end
