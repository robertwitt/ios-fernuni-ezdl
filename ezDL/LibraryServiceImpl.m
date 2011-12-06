//
//  LibraryServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryServiceImpl.h"
#import "CoreDataStack.h"
#import "ServiceFactory.h"


#pragma mark - Library User Defaults Service

@interface LibraryUserDefaultsService : NSObject

@property (nonatomic, strong, readonly) NSArray *selectedLibraryObjectIDs;

- (BOOL)isLibrarySelected:(Library *)library;
- (void)saveSelectedLibraries:(NSArray *)libraries;

@end


@implementation LibraryUserDefaultsService

static NSString *UserDefaultsKey = @"ezDL_selectedLibraries";

@synthesize selectedLibraryObjectIDs = _selectedLibraryObjectIDs;

- (NSArray *)selectedLibraryObjectIDs
{
    if (!_selectedLibraryObjectIDs) _selectedLibraryObjectIDs = [[NSUserDefaults standardUserDefaults] arrayForKey:UserDefaultsKey];
    return _selectedLibraryObjectIDs;
}

- (BOOL)isLibrarySelected:(Library *)library
{
    BOOL selected = NO;
    if ([self.selectedLibraryObjectIDs containsObject:library.dlObjectID]) selected = YES;
    return selected;
}

- (void)saveSelectedLibraries:(NSArray *)libraries
{
    NSMutableArray *libraryObjectIDs = [NSMutableArray array];
    for (Library *library in libraries)
    {
        [libraryObjectIDs addObject:library.dlObjectID];
    }
    [[NSUserDefaults standardUserDefaults] setObject:libraryObjectIDs forKey:UserDefaultsKey];
    _selectedLibraryObjectIDs = nil;
}

@end



#pragma mark - Library Core Data Service

@interface LibraryCoreDataService : NSObject

@property (nonatomic, weak, readonly) CoreDataStack *coreDataStack;

- (NSArray *)fetchLibrariesWithError:(NSError **)error;
- (NSArray *)saveLibraries;
- (void)deleteAllLibraries;

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



#pragma mark - Library Service Implementation

@interface LibraryServiceImpl ()

@property (nonatomic, strong) LibraryChoice *currentLibraryChoice;
@property (nonatomic, strong, readonly) LibraryUserDefaultsService *userDefaultsService;
@property (nonatomic, strong, readonly) LibraryCoreDataService *coreDataService;

- (NSArray *)loadLibraryFromDiskWithError:(NSError **)error;
- (NSArray *)loadLibraryFromBackendWithError:(NSError **)error;
- (LibraryChoice *)libraryChoiceFromLibraries:(NSArray *)libraries;

@end


@implementation LibraryServiceImpl

@synthesize currentLibraryChoice = _currentLibraryChoice;
@synthesize userDefaultsService = _userDefaultsService;
@synthesize coreDataService = _coreDataService;

- (LibraryUserDefaultsService *)userDefaultsService
{
    if (!_userDefaultsService) _userDefaultsService = [[LibraryUserDefaultsService alloc] init];
    return _userDefaultsService;
}

- (LibraryCoreDataService *)coreDataService
{
    if (!_coreDataService) _coreDataService = [[LibraryCoreDataService alloc] init];
    return _coreDataService;
}

- (LibraryChoice *)libraryChoice
{
    LibraryChoice *libraryChoice = self.currentLibraryChoice;
    if (!libraryChoice) libraryChoice = [self loadLibraryChoiceFromBackend:NO withError:nil];
    return libraryChoice;
}

- (LibraryChoice *)loadLibraryChoiceFromBackend:(BOOL)loadFromBackend withError:(NSError *__autoreleasing *)error
{
    NSArray *libraries = nil;
    if (!loadFromBackend)
    {
        libraries = [self loadLibraryFromDiskWithError:error];
        if (!libraries || libraries.count == 0) libraries = [self loadLibraryFromBackendWithError:error];
    }
    else
    {
        libraries = [self loadLibraryFromBackendWithError:error];
    }
    
    self.currentLibraryChoice = [self libraryChoiceFromLibraries:libraries];
    return self.currentLibraryChoice;
}

- (LibraryChoice *)libraryChoiceFromLibraries:(NSArray *)libraries {
    NSMutableArray *selectedLibraries = [NSMutableArray array];
    NSMutableArray *unselectedLibraries = [NSMutableArray array];
    
    for (Library *library in libraries)
    {
        if ([self.userDefaultsService isLibrarySelected:library])
        {
            [selectedLibraries addObject:library];
        }
        else
        {
            [unselectedLibraries addObject:library];
        }
    }
    
    LibraryChoice *libraryChoice = [[LibraryChoice alloc] initWithSelectedLibraries:selectedLibraries
                                                                unselectedLibraries:unselectedLibraries];
    return libraryChoice;
}

- (NSArray *)loadLibraryFromDiskWithError:(NSError *__autoreleasing *)error
{
    return [self.coreDataService fetchLibrariesWithError:error];
}

- (NSArray *)loadLibraryFromBackendWithError:(NSError *__autoreleasing *)error
{
    [self.coreDataService deleteAllLibraries];
    [[[ServiceFactory sharedFactory] backendService] loadLibrariesWithError:error];
    NSArray *libraries = [self.coreDataService saveLibraries];
    
    return libraries;
}

- (void)saveLibraryChoice:(LibraryChoice *)libraryChoice
{
    [self.userDefaultsService saveSelectedLibraries:libraryChoice.selectedLibraries];
    self.currentLibraryChoice = libraryChoice;
}

- (Library *)libraryWithObjectID:(NSString *)objectID
{
    NSArray *allLibraries = [self libraryChoice].allLibraries;
    NSUInteger index = [allLibraries indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BOOL passed = NO;
        Library *library = obj;
        if ([library.dlObjectID isEqualToString:objectID])
        {
            passed = YES;
            *stop = YES;
        }
        return passed;
    }];
    
    return [allLibraries objectAtIndex:index];
}

@end
