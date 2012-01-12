//
//  LibraryChoiceViewController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @class LibraryChoiceViewController
 @abstract Management of Digital Libraries and Library Choice
 @discussion This view controller loads available digital libraries from ezDL backend and displays them in table view. You can select your preferred ones by tapping the rows, those are then used in the query search. The selection (called Library Choice) is directly persisted and restored if the controller's view is displayed the next time.
 */
@interface LibraryChoiceViewController : UITableViewController

@end
