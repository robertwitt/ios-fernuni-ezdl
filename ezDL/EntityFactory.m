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

static EntityFactory *Singleton;

+ (EntityFactory *)sharedFactory
{
    if (!Singleton) Singleton = [[EntityFactory alloc] init];
    return Singleton;
}

- (CoreDataStack *)coreDataStack
{
    if (!_coreDataStack) _coreDataStack = [CoreDataStack sharedCoreDataStack];
    return _coreDataStack;
}

- (id)entityWithName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:managedObjectContext];
}

- (Author *)author
{
    return [self entityWithName:CoreDataEntityAuthor inManagedObjectContext:self.coreDataStack.scratchManagedObjectContext];
}

- (Author *)persistentAuthor
{
    return [self entityWithName:CoreDataEntityAuthor inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

- (Author *)persistentAuthorWithAuthor:(Author *)author
{
    Author *persistentAuthor = [self persistentAuthor];
    persistentAuthor.dlObjectID = author.dlObjectID;
    persistentAuthor.firstName = author.firstName;
    persistentAuthor.lastName = author.lastName;
    return persistentAuthor;
}

- (Document *)document
{
    return [self entityWithName:CoreDataEntityDocument inManagedObjectContext:self.coreDataStack.scratchManagedObjectContext];
}

- (Document *)persistentDocument
{
    return [self entityWithName:CoreDataEntityDocument inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

- (Document *)persistentDocumentWithDocument:(Document *)document
{
    Document *persistentDocument = [self persistentDocument];
    persistentDocument.dlObjectID = document.dlObjectID;
    persistentDocument.title = document.title;
    persistentDocument.year = document.year;
    
    for (Author *author in document.authors)
    {
        Author *persistentAuthor = [self persistentAuthorWithAuthor:author];
        [persistentDocument addAuthorsObject:persistentAuthor];
    }
    return persistentDocument;
}

- (DocumentDetail *)documentDetail
{
    return [self entityWithName:CoreDataEntityDocumentDetail inManagedObjectContext:self.coreDataStack.scratchManagedObjectContext];
}

- (DocumentLink *)documentLink
{
    return [self entityWithName:CoreDataEntityDocumentLink inManagedObjectContext:self.coreDataStack.scratchManagedObjectContext];
}

- (Library *)persistentLibrary
{
    return [self entityWithName:CoreDataEntityLibrary inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

- (PersonalLibraryGroup *)persistentPersonalLibraryGroup
{
    return [self entityWithName:CoreDataEntityPersonalLibraryGroup inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

- (PersonalLibraryReference *)persistentPersonalLibraryReference
{
    return [self entityWithName:CoreDataEntityPersonalLibraryReference inManagedObjectContext:self.coreDataStack.managedObjectContext];
}

@end
