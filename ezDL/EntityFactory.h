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


/*!
 @class EntityFactory
 @abstract Factory class to create new entities
 @discussion To create an entity, i. e. an NSManagedObject, you need a lot of details: the managed object context the entity has to be added to as well as the entity description name in the managed object model. To simplify the entity creation process and to hide those details this class has been created that offers methods to clients to build new entity instances. 
 Most object types are needed in two flavors: as persistent entities to store it on disk and as transient entities that aren't needed anymore when their context has been left. Also sometimes clients need to copy a persistent entity to a transient entity and vice versa. There are methods for this, too.
 This class only creates the entities and adds them to the managed object context of CoreDataStack class. It does not save the context and so persist the entities. Clients have to do this by themselves.
 */
@interface EntityFactory : NSObject

/*!
 @method sharedFactory
 @abstract Returns singleton instance of this class
 @return EntityFactory instance
 */
+ (EntityFactory *)sharedFactory;

/*!
 @method author
 @abstract Creates a transient Author object
 @return The new entity
 */
- (Author *)author;

/*!
 @method authorWithPersistentAuthor:
 @abstract Copies state of specified persistent author into a new transient author
 @param persistentAuthor A persistent Author object
 @return The new entity
 */
- (Author *)authorWithPersistentAuthor:(Author *)persistentAuthor;

/*!
 @method persistentAuthor
 @abstract Creates a persistent Author object
 @return The new entity
 */
- (Author *)persistentAuthor;

/*!
 @method persistentAuthorWithAuthor:
 @abstract Copies state of specified transient author into a new persistent author
 @param author A transient Author object
 @return The new entity
 */
- (Author *)persistentAuthorWithAuthor:(Author *)author;

/*!
 @method document
 @abstract Creates a transient Document object
 @return The new entity
 */
- (Document *)document;

/*!
 @method documentWithPersistentDocument:
 @abstract Copies state of specified persistent document into a new transient document
 @param persistentDocument A persistent Document object
 @return The new entity
 */
- (Document *)documentWithPersistentDocument:(Document *)persistentDocument;

/*!
 @method persistentDocument
 @abstract Creates a persistent Document object
 @return The new entity
 */
- (Document *)persistentDocument;

/*!
 @method persistentDocumentWithDocument:
 @abstract Copies state of specified transient document into a new persistent document
 @param document A transient Document object
 @return The new entity
 */
- (Document *)persistentDocumentWithDocument:(Document *)document;

/*!
 @method documentDetail
 @abstract Creates a transient DocumentDetail object
 @return The new entity
 */
- (DocumentDetail *)documentDetail;

/*!
 @method documentDetailWithPersistentDetail:
 @abstract Copies state of specified persistent document detail into a new transient document detail
 @param persistentDetail A persistent DocumentDetail object
 @return The new entity
 */
- (DocumentDetail *)documentDetailWithPersistentDetail:(DocumentDetail *)persistentDetail;

/*!
 @method persistentDocumentDetail
 @abstract Creates a persistent DocumentDetail object
 @return The new entity
 */
- (DocumentDetail *)persistentDocumentDetail;

/*!
 @method persistentDocumentDetailWithDetail:
 @abstract Copies state of specified transient document detail into a new persistent document detail
 @param detail A transient DocumentDetail object
 @return The new entity
 */
- (DocumentDetail *)persistentDocumentDetailWithDetail:(DocumentDetail *)detail;

/*!
 @method addDocumentDetail:toDocument:
 @abstract Assigns the given DocumentDetail to a Document object
 @param detail A DocumentDetail object
 @param document A Document object
 */
- (void)addDocumentDetail:(DocumentDetail *)detail toDocument:(Document *)document;

/*!
 @method documentLink
 @abstract Creates a transient DocumentLink object
 @return The new entity
 */
- (DocumentLink *)documentLink;

/*!
 @method documentLinkWithPersistentLink:
 @abstract Copies state of specified persistent document link into a new transient document link
 @param persistentLink A persistent DocumentLink object
 @return The new entity
 */
- (DocumentLink *)documentLinkWithPersistentLink:(DocumentLink *)persistentLink;

/*!
 @method persistentDocumentLink
 @abstract Creates a persistent DocumentLink object
 @return The new entity
 */
- (DocumentLink *)persistentDocumentLink;

/*!
 @method persistentDocumentLinkWithLink:
 @abstract Copies state of specified transient document link into a new persistent document link
 @param link A transient DocumentLink object
 @return The new entity
 */
- (DocumentLink *)persistentDocumentLinkWithLink:(DocumentLink *)link;

/*!
 @method persistentLibrary
 @abstract Creates a persistent Library object
 @return The new entity
 */
- (Library *)persistentLibrary;

/*!
 @method persistentPersonalLibraryGroup
 @abstract Creates a persistent PersonalLibraryGroup object
 @return The new entity
 */
- (PersonalLibraryGroup *)persistentPersonalLibraryGroup;

/*!
 @method persistentPersonalLibraryReference
 @abstract Creates a persistent PersonalLibraryReference object
 @return The new entity
 */
- (PersonalLibraryReference *)persistentPersonalLibraryReference;

@end
