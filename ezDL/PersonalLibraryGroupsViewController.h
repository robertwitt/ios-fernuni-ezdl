//
//  PersonalLibraryGroupsViewController.h
//  ezDL
//
//  Created by Robert Witt on 06.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroupAddViewController.h"


@class PersonalLibraryGroupsViewController;


/*!
 @protocol PersonalLibraryGroupsViewControllerDelegate
 @abstract Delegate protocol of the PersonalLibraryGroupsViewController
 @discussion The Personal Library Groups View Controller communicates groups changes or changes in selection to its delegate via this protocol.
 */
@protocol PersonalLibraryGroupsViewControllerDelegate <NSObject>

@optional

/*!
 @method groupsViewController:didAddGroup:
 @abstract Sent to delegate if user has added a new group
 @param viewController The PersonalLibraryGroupsViewController as sender
 @param group The group that was added
 */
- (void)groupsViewController:(PersonalLibraryGroupsViewController *)viewController didAddGroup:(PersonalLibraryGroup *)group;

/*!
 @method groupsViewController:didDeleteGroup:
 @abstract Sent to delegate if user has removed a group
 @param viewController The PersonalLibraryGroupsViewController as sender
 @param group The group that was removed
 */
- (void)groupsViewController:(PersonalLibraryGroupsViewController *)viewController didDeleteGroup:(PersonalLibraryGroup *)group;

/*!
 @method groupsViewController:didChangeGroupSelection:
 @abstract Sent to delegate if user has changed the group selection
 @param viewController The PersonalLibraryGroupsViewController as sender
 @param group Array of groups that are now selected
 */
- (void)groupsViewController:(PersonalLibraryGroupsViewController *)viewController didChangeGroupSelection:(NSArray *)groups;

@end


/*!
 @class PersonalLibraryGroupsViewController
 @abstract Management of Personal Library Groups
 @discussion All existing groups are displayed in a table view, the user can select and deselect entries. User actions are sent to interested clients via PersonalLibraryGroupsViewControllerDelegate protocol. Editing, i. e. adding and removing of groups, is possible by standard UITableView functionality.
 */
@interface PersonalLibraryGroupsViewController : UITableViewController

/*!
 @property displayedGroups
 @abstract Array with PersonalLibraryGroups the view controller should mark initially as selected
 */
@property (nonatomic, strong) NSArray *displayedGroups;

/*!
 @property delegate
 @abstract Delegate to send group changes to
 */
@property (nonatomic, weak) id<PersonalLibraryGroupsViewControllerDelegate> delegate;

@end
