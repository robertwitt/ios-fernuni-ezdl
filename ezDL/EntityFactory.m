//
//  EntityFactory.m
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EntityFactory.h"
#import "CoreDataStack.h"
#import "Author.h"
#import "Document.h"
#import "DocumentDetail.h"
#import "DocumentLink.h"
#import "Library.h"
#import "PersonalLibraryGroup.h"
#import "PersonalLibraryReference.h"


@interface EntityFactory ()

@property (nonatomic, strong, readonly) CoreDataStack *coreDataStack;

- (id)entityWithName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end


@implementation EntityFactory

@synthesize coreDataStack = _coreDataStack;

#pragma mark Object Management as Singleton

static EntityFactory *Singleton;

+ (EntityFactory *)sharedFactory {
    if (!Singleton) Singleton = [[EntityFactory alloc] init];
    return Singleton;
}

- (CoreDataStack *)coreDataStack {
    if (!_coreDataStack) _coreDataStack = [CoreDataStack sharedCoreDataStack];
    return _coreDataStack;
}

#pragma mark Auxiliary Methods

- (id)entityWithName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:managedObjectContext];
}

#pragma mark Factory Methods for Authors

- (Author *)author {
    return [self entityWithName:CoreDataEntityAuthor inManagedObjectContext:self.coreDataStack.scratchManagedObjectContext];
}

- (Author *)authorWithPersistentAuthor:(Author *)persistentAuthor {
    Author *author = [self author];
    author.dlObjectID = persistentAuthor.dlObjectID;
    author.firstName = persistentAuthor.firstName;
    author.lastName = persistentAuthor.lastName;
    return author;
}

- (Author *)persistentAuthor {
    return [self entityWithName:CoreDataEntityAuthor inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

- (Author *)persistentAuthorWithAuthor:(Author *)author {
    Author *persistentAuthor = [self persistentAuthor];
    persistentAuthor.dlObjectID = author.dlObjectID;
    persistentAuthor.firstName = author.firstName;
    persistentAuthor.lastName = author.lastName;
    return persistentAuthor;
}

#pragma mark Factory Methods for Documents

- (Document *)document {
    return [self entityWithName:CoreDataEntityDocument inManagedObjectContext:self.coreDataStack.scratchManagedObjectContext];
}

- (Document *)documentWithPersistentDocument:(Document *)persistentDocument {
    Document *document = [self document];
    document.dlObjectID = persistentDocument.dlObjectID;
    document.title = persistentDocument.title;
    document.year = persistentDocument.year;
    
    for (Author *persistentAuthor in persistentDocument.authors) {
        Author *author = [self authorWithPersistentAuthor:persistentAuthor];
        [document addAuthorsObject:author];
    }
    return document;
}

- (Document *)persistentDocument {
    return [self entityWithName:CoreDataEntityDocument inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

- (Document *)persistentDocumentWithDocument:(Document *)document {
    Document *persistentDocument = [self persistentDocument];
    persistentDocument.dlObjectID = document.dlObjectID;
    persistentDocument.title = document.title;
    persistentDocument.year = document.year;
    
    for (Author *author in document.authors) {
        Author *persistentAuthor = [self persistentAuthorWithAuthor:author];
        [persistentDocument addAuthorsObject:persistentAuthor];
    }
    return persistentDocument;
}

#pragma mark Factory Methods for Document Detail

- (DocumentDetail *)documentDetail {
    return [self entityWithName:CoreDataEntityDocumentDetail inManagedObjectContext:self.coreDataStack.scratchManagedObjectContext];
}

- (DocumentDetail *)documentDetailWithPersistentDetail:(DocumentDetail *)persistentDetail {
    DocumentDetail *detail = [self documentDetail];
    detail.abstract = persistentDetail.abstract;
    
    for (DocumentLink *persistentLink in persistentDetail.links) {
        DocumentLink *link = [self documentLinkWithPersistentLink:persistentLink];
        [detail addLinksObject:link];
    }
    return detail;
}

- (DocumentDetail *)persistentDocumentDetail {
    return [self entityWithName:CoreDataEntityDocumentDetail inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

- (DocumentDetail *)persistentDocumentDetailWithDetail:(DocumentDetail *)detail {
    DocumentDetail *persistentDetail = [self persistentDocumentDetail];
    persistentDetail.abstract = detail.abstract;
    
    for (DocumentLink *link in detail.links) {
        DocumentLink *persistentLink = [self persistentDocumentLinkWithLink:link];
        [persistentDetail addLinksObject:persistentLink];
    }
    return persistentDetail;
}

- (void)addDocumentDetail:(DocumentDetail *)detail toDocument:(Document *)document
{
    // This method is a little bad design. Reason is the Document Detail View Controller is used in both Query and Personal Library. Since those tools work with different object types (transient vs. persistent objects), loading the document details and assigning them to the document object needs a copy to the correct context first. Since only the Entity Factory knows about the managed object context, we have this method here.
    
    NSManagedObjectContext *documentContext = document.managedObjectContext;
    NSManagedObjectContext *detailContext = detail.managedObjectContext;
    
    if (documentContext == detailContext) {
        document.detail = detail;
    }
    else {
        if (documentContext == self.coreDataStack.managedObjectContext) {
            document.detail = [self persistentDocumentDetailWithDetail:detail];
        }
        else {
            document.detail = [self documentDetailWithPersistentDetail:detail];
        }
    }
}

#pragma mark Factory Methods for Document Link

- (DocumentLink *)documentLink {
    return [self entityWithName:CoreDataEntityDocumentLink inManagedObjectContext:self.coreDataStack.scratchManagedObjectContext];
}

- (DocumentLink *)documentLinkWithPersistentLink:(DocumentLink *)persistentLink {
    DocumentLink *link = [self documentLink];
    link.urlString = persistentLink.urlString;
    return link;
}

- (DocumentLink *)persistentDocumentLink {
    return [self entityWithName:CoreDataEntityDocumentLink inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

- (DocumentLink *)persistentDocumentLinkWithLink:(DocumentLink *)link {
    DocumentLink *persistentLink = [self persistentDocumentLink];
    persistentLink.urlString = link.urlString;
    return persistentLink;
}

#pragma mark Factory Methods for Libraries

- (Library *)persistentLibrary {
    return [self entityWithName:CoreDataEntityLibrary inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

#pragma mark Factory Methods for Personal Library Groups

- (PersonalLibraryGroup *)persistentPersonalLibraryGroup {
    return [self entityWithName:CoreDataEntityPersonalLibraryGroup inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

#pragma mark Factory Methods for Personal Library References

- (PersonalLibraryReference *)persistentPersonalLibraryReference {
    return [self entityWithName:CoreDataEntityPersonalLibraryReference inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

@end
