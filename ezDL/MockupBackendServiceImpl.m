//
//  MockupBackendServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MockupBackendServiceImpl.h"
#import "MockupLibraryBackendService.h"
#import "MockupQueryBackendService.h"

@implementation MockupBackendServiceImpl

- (NSArray *)loadLibrariesWithError:(NSError *__autoreleasing *)error
{
    MockupLibraryBackendService *service = [[MockupLibraryBackendService alloc] init];
    NSArray *libraries = [service loadLibraries];
    
    // Introduce artificial response time from Backend
    sleep(2);
    
    return libraries;
}

- (QueryResult *)executeQuery:(id<Query>)query withError:(NSError *__autoreleasing *)error
{
    MockupQueryBackendService *service = [[MockupQueryBackendService alloc] init];
    NSArray *queryResultItems = [service loadQueryResultItems];
    
    NSIndexSet *indexes = [queryResultItems indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BOOL passed = NO;
        if ([[query selectedLibraries] containsObject:obj]) passed = YES;
        return YES;
    }];
    queryResultItems = [queryResultItems objectsAtIndexes:indexes];
    
    [query setExecutedOn:[NSDate date]];
    QueryResult *queryResult = [QueryResult queryResultWithQuery:query items:queryResultItems];
    
    // Introduce artificial response time from Backend
    sleep(2);
    
    return queryResult;
}

@end
