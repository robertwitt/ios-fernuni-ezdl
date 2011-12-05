//
//  EntityFactory.h
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class Author;
@class Document;
@class DocumentDetail;
@class DocumentLink;
@class Library;
@class PersonalLibraryGroup;
@class PersonalLibraryReference;

@interface EntityFactory : NSObject

+ (EntityFactory *)sharedFactory;

- (Author *)author;
- (Author *)persistentAuthor;
- (Author *)persistentAuthorWithAuthor:(Author *)author;

- (Document *)document;
- (Document *)persistentDocument;
- (Document *)persistentDocumentWithDocument:(Document *)document;

- (DocumentDetail *)documentDetail;
- (DocumentLink *)documentLink;
- (Library *)persistentLibrary;
- (PersonalLibraryGroup *)persistentPersonalLibraryGroup;
- (PersonalLibraryReference *)persistentPersonalLibraryReference;

@end
