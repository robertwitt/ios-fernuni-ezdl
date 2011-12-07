//
//  PersonalLibraryGroupsViewController.h
//  ezDL
//
//  Created by Robert Witt on 06.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroupAddViewController.h"


@class PersonalLibraryGroupsViewController;
@protocol PersonalLibraryGroupsViewControllerDelegate <NSObject>

@optional
- (void)groupsViewController:(PersonalLibraryGroupsViewController *)viewController didAddGroup:(PersonalLibraryGroup *)group;
- (void)groupsViewController:(PersonalLibraryGroupsViewController *)viewController didDeleteGroup:(PersonalLibraryGroup *)group;
- (void)groupsViewController:(PersonalLibraryGroupsViewController *)viewController didChangeGroupSelection:(NSArray *)groups;

@end


@interface PersonalLibraryGroupsViewController : UITableViewController <PersonalLibraryGroupAddViewControllerDelegate>

@property (nonatomic, strong) NSArray *displayedGroups;
@property (nonatomic, weak) id<PersonalLibraryGroupsViewControllerDelegate> delegate;

@end
