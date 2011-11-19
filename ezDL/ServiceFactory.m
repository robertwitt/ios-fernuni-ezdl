//
//  ServiceFactory.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ServiceFactory.h"
#import "CoreDataServiceImpl.h"
#import "LibraryServiceImpl.h"
#import "MockupBackendServiceImpl.h"
#import "QueryServiceImpl.h"

@implementation ServiceFactory

static ServiceFactory *Singleton;
static QueryServiceImpl *QueryServiceImplSingleton;
static LibraryServiceImpl *LibraryServiceImplSingleton;
static CoreDataServiceImpl *CoreDataServiceImplSingleton;
static MockupBackendServiceImpl *MockupBackendServiceImplSingleton;

+ (ServiceFactory *)sharedFactory
{
    if (!Singleton) Singleton = [[ServiceFactory alloc] init];
    return Singleton;
}

- (id<QueryService>)queryService
{
    if (!QueryServiceImplSingleton) QueryServiceImplSingleton = [[QueryServiceImpl alloc] init];
    return QueryServiceImplSingleton;
}

- (id<LibraryService>)libraryService
{
    if (!LibraryServiceImplSingleton) LibraryServiceImplSingleton = [[LibraryServiceImpl alloc] init];
    return LibraryServiceImplSingleton;
}

- (id<CoreDataService>)coreDataService
{
    if (!CoreDataServiceImplSingleton) CoreDataServiceImplSingleton = [[CoreDataServiceImpl alloc] init];
    return CoreDataServiceImplSingleton;
}

- (id<BackendService>)backendService
{
    // MOCKUP After mockup replace this implementation with actual one
    if (!MockupBackendServiceImplSingleton) MockupBackendServiceImplSingleton = [[MockupBackendServiceImpl alloc] init];
    return MockupBackendServiceImplSingleton;
}

@end
