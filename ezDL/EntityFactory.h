//
//  EntityFactory.h
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Author.h"
#import "Document.h"
#import "DocumentDetail.h"
#import "DocumentLink.h"
#import "Library.h"
#import "PersonalLibraryGroup.h"
#import "PersonalLibraryReference.h"

@interface EntityFactory : NSObject

+ (EntityFactory *)sharedFactory;

- (Author *)author;
- (Author *)authorWithPersistentAuthor:(Author *)persistentAuthor;
- (Author *)persistentAuthor;
- (Author *)persistentAuthorWithAuthor:(Author *)author;

- (Document *)document;
- (Document *)documentWithPersistentDocument:(Document *)persistentDocument;
- (Document *)persistentDocument;
- (Document *)persistentDocumentWithDocument:(Document *)document;

- (DocumentDetail *)documentDetail;
- (DocumentDetail *)documentDetailWithPersistentDetail:(DocumentDetail *)persistentDetail;
- (DocumentDetail *)persistentDocumentDetail;
- (DocumentDetail *)persistentDocumentDetailWithDetail:(DocumentDetail *)detail;
- (void)addDocumentDetail:(DocumentDetail *)detail toDocument:(Document *)document;

- (DocumentLink *)documentLink;
- (DocumentLink *)documentLinkWithPersistentLink:(DocumentLink *)persistentLink;
- (DocumentLink *)persistentDocumentLink;
- (DocumentLink *)persistentDocumentLinkWithLink:(DocumentLink *)link;

- (Library *)persistentLibrary;
- (PersonalLibraryGroup *)persistentPersonalLibraryGroup;
- (PersonalLibraryReference *)persistentPersonalLibraryReference;

@end
