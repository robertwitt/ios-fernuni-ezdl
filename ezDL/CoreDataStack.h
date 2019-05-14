//
//  CoreDataStack.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

static NSString *CoreDataEntityAuthor = @"Author";
static NSString *CoreDataEntityDocument = @"Document";
static NSString *CoreDataEntityDocumentDetail = @"DocumentDetail";
static NSString *CoreDataEntityDocumentLink = @"DocumentLink";
static NSString *CoreDataEntityLibrary = @"Library";
static NSString *CoreDataEntityPersonalLibraryReference = @"PersonalLibraryReference";
static NSString *CoreDataEntityPersonalLibraryGroup = @"PersonalLibraryGroup";


/*!
 @class CoreDataStack
 @abstract Implementation of the Core Data Stack
 @discussion This class encapsulates the Core Data object as it is foreseen by the framework. It has readonly properties to allow clients to access the properties but not to overwrite them. In the end most clients are only interested in the managedObjectContext property, the managed object context all managed objects have to be added to in order to persist them on disk. The message saveContext does the actual saving of managedObjectContext.
 To realise also transient entities in the application, the scratchManagedObjectContext property exist, another NSManagedObjectContext instance which, however, won't be saved by the CoreDataStack. So all managed objects added to this context will be removed from memory at some time.
 */
@interface CoreDataStack : NSObject

/*!
 @property managedObjectContext
 @abstract Managed object context to persist NSManagedObjects in the application
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

/*!
 @property managedObjectModel
 @abstract Managed object model in the application
 */
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;

/*!
 @property persistentStoreCoordinator
 @abstract Persistent store coordinator in the application
 */
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/*!
 @property scratchManagedObjectContext
 @abstract Not-saved managed object context for transient NSManagedObjects in the application
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *scratchManagedObjectContext;

/*!
 @method sharedCoreDataStack
 @abstract Returns singleton instance of this class
 @return CoreDataStack instance
 */
+ (CoreDataStack *)sharedCoreDataStack;

/*!
 @method saveContext
 @abstract Saves the managedObjectContext (not scratchManagedObjectContext)
 */
- (void)saveContext;

@end
