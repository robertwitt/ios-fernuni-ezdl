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


@interface CoreDataStack : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readonly) NSManagedObjectContext *scratchManagedObjectContext;

+ (CoreDataStack *)sharedCoreDataStack;
- (void)saveContext;

@end
