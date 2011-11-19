//
//  LibraryServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryServiceImpl.h"
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
    if ([self.selectedLibraryObjectIDs containsObject:library.objectID]) selected = YES;
    return selected;
}

- (void)saveSelectedLibraries:(NSArray *)libraries
{
    NSMutableArray *libraryObjectIDs = [NSMutableArray array];
    for (Library *library in libraries)
    {
        [libraryObjectIDs addObject:library.objectID];
    }
    [[NSUserDefaults standardUserDefaults] setObject:libraryObjectIDs forKey:UserDefaultsKey];
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
    NSArray *libraries = [[[ServiceFactory sharedFactory] coreDataService] loadLibrariesWithError:error];
    if (!libraries || libraries.count == 0) libraries = [self loadLibraryFromBackendWithError:error];
    return libraries;
}

- (NSArray *)loadLibraryFromBackendWithError:(NSError *__autoreleasing *)error
{
    ServiceFactory *serviceFactory = [ServiceFactory sharedFactory];
    NSArray *libraries = [[serviceFactory backendService] loadLibrariesWithError:error];
    [[serviceFactory coreDataService] saveLibraries:libraries];
    
    return libraries;
}

- (void)saveLibraryChoice:(LibraryChoice *)libraryChoice
{
    [self.userDefaultsService saveSelectedLibraries:libraryChoice.selectedLibraries];
    self.currentLibraryChoice = libraryChoice;
}

- (Library *)libraryWithObjectID:(NSString *)objectID
{
    NSArray *selectedLibraries = [self libraryChoice].selectedLibraries;
    NSUInteger index = [selectedLibraries indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BOOL passed = NO;
        if ([[obj objectID] isEqualToString:objectID])
        {
            passed = YES;
            stop = &passed;
        }
        return passed;
    }];
    
    return [selectedLibraries objectAtIndex:index];
}

@end
