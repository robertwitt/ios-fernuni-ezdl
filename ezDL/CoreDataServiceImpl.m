//
//  CoreDataServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CoreDataServiceImpl.h"
#import "CoreDataStack.h"


@interface CoreDataServiceImpl ()

@property (nonatomic, weak, readonly) CoreDataStack *coreDataStack;

@end


@implementation CoreDataServiceImpl

@synthesize coreDataStack = _coreDataStack;

- (CoreDataStack *)coreDataStack
{
    if (!_coreDataStack) _coreDataStack = [CoreDataStack sharedCoreDataStack];
    return _coreDataStack;
}

- (NSArray *)fetchLibrariesWithError:(NSError *__autoreleasing *)error
{
    // Fetch result from disk. First create a request for library entity.
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CoreDataEntityLibrary
                                              inManagedObjectContext:self.coreDataStack.managedObjectContext];
    request.entity = entity;
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:kLibraryName ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    // Execute the request
    return [self.coreDataStack.managedObjectContext executeFetchRequest:request error:error];
}

- (NSArray *)saveLibraries
{
    [self.coreDataStack saveContext];
    return [self fetchLibrariesWithError:nil];
}

- (void)deleteAllLibraries
{
    for (Library *library in [self fetchLibrariesWithError:nil])
    {
        [self.coreDataStack.managedObjectContext deleteObject:library];
    }
}

@end
