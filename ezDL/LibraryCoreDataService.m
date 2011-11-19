//
//  LibraryCoreDataService.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryCoreDataService.h"
#import "CoreDataStack.h"
#import "Library.h"
#import "LibraryMO.h"


@interface LibraryCoreDataService ()

@property (nonatomic, weak, readonly) CoreDataStack *coreDataStack;

- (NSArray *)fetchLibraryMOsWithError:(NSError **)error;
- (NSArray *)librariesFromLibraryMOs:(NSArray *)libraryMOs;
- (void)saveLibrary:(Library *)library;

@end


@implementation LibraryCoreDataService

@synthesize coreDataStack = _coreDataStack;

- (CoreDataStack *)coreDataStack
{
    if (!_coreDataStack) _coreDataStack = [CoreDataStack sharedCoreDataStack];
    return _coreDataStack;
}

- (NSArray *)fetchLibrariesWithError:(NSError *__autoreleasing *)error
{
    NSArray *libraryMOs = [self fetchLibraryMOsWithError:error];
    return [self librariesFromLibraryMOs:libraryMOs];
}

- (NSArray *)fetchLibraryMOsWithError:(NSError *__autoreleasing *)error
{
    // Fetch result from disk. First create a request for library entity.
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CoreDataEntityLibrary
                                              inManagedObjectContext:self.coreDataStack.managedObjectContext];
    request.entity = entity;
    
    // Execute the request
    return [self.coreDataStack.managedObjectContext executeFetchRequest:request error:nil]; 
}

- (NSArray *)librariesFromLibraryMOs:(NSArray *)libraryMOs
{
    NSMutableArray *libraries = [NSMutableArray array];
    
    for (LibraryMO *libraryMO in libraryMOs)
    {
        Library *library = [[Library alloc] initWithObjectID:libraryMO.objID];
        library.name = libraryMO.name;
        library.shortDescription = libraryMO.shortDescr;
        [libraries addObject:library];
    }
    return libraries;
}

- (void)saveLibraries:(NSArray *)libraries
{
    for (Library *library in libraries)
    {
        [self saveLibrary:library];
    }
    
    // Save managed object context
    [self.coreDataStack saveContext];
}

- (void)saveLibrary:(Library *)library
{    
    LibraryMO *libraryMO = (LibraryMO *)[NSEntityDescription insertNewObjectForEntityForName:CoreDataEntityLibrary
                                                                      inManagedObjectContext:self.coreDataStack.managedObjectContext];
    libraryMO.objID = library.objectID;
    libraryMO.name = library.name;
    libraryMO.shortDescr = library.shortDescription;
}

- (void)deleteAllLibraries {
    // Perform delete on disk. It is inefficient to fetch first all the managed objects and then delete them one after the other. But I don't see another solution right now.
    for (LibraryMO *libraryMO in [self fetchLibraryMOsWithError:nil])
    {
        [self.coreDataStack.managedObjectContext deleteObject:libraryMO];
    }
}

@end
