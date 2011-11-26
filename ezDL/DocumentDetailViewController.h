//
//  DocumentDetailViewController.h
//  ezDL
//
//  Created by Robert Witt on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Document.h"


@class DocumentDetailViewController;
@protocol DocumentDetailViewControllerDelegate <NSObject>

- (NSInteger)documentDetailViewControllerNumberOfDocuments:(DocumentDetailViewController *)viewController;
- (Document *)documentDetailViewController:(DocumentDetailViewController *)viewController nextDocumentAfter:(Document *)document;
- (Document *)documentDetailViewController:(DocumentDetailViewController *)viewController previousDocumentAfter:(Document *)document;

@end


@interface DocumentDetailViewController : UITableViewController

@property (nonatomic, strong) Document *displayedDocument;
@property (nonatomic, weak) id<DocumentDetailViewControllerDelegate> delegate;

@end
