//
//  DocumentDetailViewController.h
//  ezDL
//
//  Created by Robert Witt on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DocumentLinkViewController.h"
#import "PersonalLibraryReferenceAddViewController.h"


@class DocumentDetailViewController;


/*!
 @protocol DocumentDetailViewControllerDelegate
 @abstract Delegate of the Document Detail View Controller
 @discussion You can use this delegate to enable iteration over a list of documents. The delegate has to implement the defined methods to support the iteration.
 */
@protocol DocumentDetailViewControllerDelegate <NSObject>

/*!
 @method documentDetailViewControllerNumberOfDocuments:
 @abstract Asks the delegate how many documents are in the list.
 @param viewController The Document Detail View Controller
 @result Number of documents in the delegate's list
 */
- (NSInteger)documentDetailViewControllerNumberOfDocuments:(DocumentDetailViewController *)viewController;

/*!
 @method documentDetailViewController:indexOfDocument:
 @abstract Asks the delegate to give the index in its list for the specified document
 @param viewController The Document Detail View Controller
 @param document A Document object
 @result Index of the document in the list
 */
- (NSInteger)documentDetailViewController:(DocumentDetailViewController *)viewController indexOfDocument:(Document *)document;

/*!
 @method documentDetailViewController:documentAtIndex:
 @abstract Asks the delegate to give the document at the specified index in the list
 @param viewController The Document Detail View Controller
 @param index List index
 @result The document at the specified index
 */
- (Document *)documentDetailViewController:(DocumentDetailViewController *)viewController documentAtIndex:(NSInteger)index;

@end


/*!
 @class DocumentDetailViewController
 @abstract Display of a Document in a table view
 @discussion This table view controller displays the document attributes (title, autors, year, etc.) in the table view rows divided into sections that represent the attribute types.
 If the calling controller that navigates to the DocumentDetailViewController manages a list of documents (like the Query Result View Controller does), you can use the delegate (protocol DocumentDetailViewControllerDelegate) to enable a iteration function to iterate over the entire document list without leaving the Document Detail View Controller. If the delegate is set, buttons to iterate are added to the navigation bar.
 */
@interface DocumentDetailViewController : UITableViewController

/*!
 @property displayedDocument
 @abstract Document object the view controller manages and displays
 */
@property (nonatomic, strong) Document *displayedDocument;

/*!
 @property hideAddReferenceItem
 @abstract Indicates whether or not the bar button item to add a document as reference to the Personal Library shoud be hidden
 */
@property (nonatomic) BOOL hideAddReferenceItem;

/*!
 @property delegate
 @abstract Optional delegate of this view controller
 */
@property (nonatomic, weak) id<DocumentDetailViewControllerDelegate> delegate;

@end
