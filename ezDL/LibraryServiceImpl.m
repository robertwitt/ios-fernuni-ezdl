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


#pragma mark - Library Service Implementation

@interface LibraryServiceImpl ()

@property (nonatomic, strong) LibraryChoice *currentLibraryChoice;
@property (nonatomic, strong, readonly) LibraryUserDefaultsService *userDefaultsService;

- (NSArray *)loadLibraryFromDiskWithError:(NSError **)error;
- (NSArray *)loadLibraryFromBackendWithError:(NSError **)error;
- (LibraryChoice *)libraryChoiceFromLibraries:(NSArray *)libraries;

@end


@implementation LibraryServiceImpl

@synthesize currentLibraryChoice = _currentLibraryChoice;
@synthesize userDefaultsService = _userDefaultsService;

- (LibraryUserDefaultsService *)userDefaultsService
{
    if (!_userDefaultsService) _userDefaultsService = [[LibraryUserDefaultsService alloc] init];
    return _userDefaultsService;
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
    return [[[ServiceFactory sharedFactory] coreDataService] fetchLibrariesWithError:error];
}

- (NSArray *)loadLibraryFromBackendWithError:(NSError *__autoreleasing *)error
{
    ServiceFactory *serviceFactory = [ServiceFactory sharedFactory];
    
    [[serviceFactory coreDataService] deleteAllLibraries];
    NSArray *libraries = [[serviceFactory backendService] loadLibrariesWithError:error];
    libraries = [[[ServiceFactory sharedFactory] coreDataService] saveLibraries];
    
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
