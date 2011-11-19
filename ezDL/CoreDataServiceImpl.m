//
//  CoreDataServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CoreDataServiceImpl.h"
#import "LibraryCoreDataService.h"


@interface CoreDataServiceImpl ()

@property (nonatomic, strong, readonly) LibraryCoreDataService *libraryCoreDataService;

@end


@implementation CoreDataServiceImpl

@synthesize libraryCoreDataService = _libraryCoreDataService;

- (LibraryCoreDataService *)libraryCoreDataService
{
    if (!_libraryCoreDataService) _libraryCoreDataService = [[LibraryCoreDataService alloc] init];
    return _libraryCoreDataService;
}

- (NSArray *)loadLibrariesWithError:(NSError *__autoreleasing *)error
{
    return [self.libraryCoreDataService fetchLibrariesWithError:error];
}

- (void)saveLibraries:(NSArray *)libraries
{
    [self.libraryCoreDataService deleteAllLibraries];
    [self.libraryCoreDataService saveLibraries:libraries];
}

@end
