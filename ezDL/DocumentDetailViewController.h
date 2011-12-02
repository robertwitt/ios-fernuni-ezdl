//
//  DocumentDetailViewController.h
//  ezDL
//
//  Created by Robert Witt on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Document.h"
#import "DocumentLinkViewController.h"
#import "PersonalLibraryReferenceAddViewController.h"


@class DocumentDetailViewController;
@protocol DocumentDetailViewControllerDelegate <NSObject>

- (NSInteger)documentDetailViewControllerNumberOfDocuments:(DocumentDetailViewController *)viewController;
- (NSInteger)documentDetailViewController:(DocumentDetailViewController *)viewController indexOfDocuments:(Document *)document;
- (Document *)documentDetailViewController:(DocumentDetailViewController *)viewController documentAtIndex:(NSInteger)index;

@end


@interface DocumentDetailViewController : UITableViewController <DocumentLinkViewControllerDelegate, PersonalLibraryReferenceAddViewControllerDelegate>

@property (nonatomic, strong) Document *displayedDocument;
@property (nonatomic, weak) id<DocumentDetailViewControllerDelegate> delegate;

@end
