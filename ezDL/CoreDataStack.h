//
//  CoreDataStack.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

static NSString *CoreDataEntityLibrary = @"LibraryMO";
static NSString *CoreDataEntityDocument = @"DocumentMO";
static NSString *CoreDataEntityAuthor = @"AuthorMO";
static NSString *CoreDataEntityPersonalLibraryReference = @"PersonalLibraryReferenceMO";
static NSString *CoreDataEntityPersonalLibraryGroup = @"PersonalLibraryGroupMO";

@interface CoreDataStack : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataStack *)sharedCoreDataStack;
- (void)saveContext;

@end
