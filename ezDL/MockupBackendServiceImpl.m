//
//  MockupBackendServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MockupBackendServiceImpl.h"
#import "MockupDocumentBackendService.h"
#import "MockupLibraryBackendService.h"
#import "MockupQueryBackendService.h"
#import "MockupWebQueryBackendService.h"
#import "QueryResultItem.h"

@implementation MockupBackendServiceImpl

- (NSArray *)loadLibrariesWithError:(NSError *__autoreleasing *)error {
    MockupLibraryBackendService *service = [[MockupLibraryBackendService alloc] init];
    NSArray *libraries = [service loadLibraries];
    
    // Introduce artificial response time from Backend
    sleep(2);
    
    return libraries;
}

- (QueryResult *)executeQuery:(Query *)query withError:(NSError *__autoreleasing *)error {
    //MockupWebQueryBackendService *service = [[MockupWebQueryBackendService alloc] init];
    //NSArray *queryResultItems = [service loadQueryResultItemsWithError:error];
    
    MockupQueryBackendService *service = [[MockupQueryBackendService alloc] init];
    NSArray *queryResultItems = [service loadQueryResultItems];
    //sleep(2);
    
    if (!error) query.executedOn = [NSDate date];
    
    NSIndexSet *indexes = [queryResultItems indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BOOL passed = NO;
        Library *library = [obj library];
        if ([query.selectedLibraries containsObject:library]) passed = YES;
        return passed;
    }];
    queryResultItems = [queryResultItems objectsAtIndexes:indexes];
    
    QueryResult *queryResult = [QueryResult queryResultWithQuery:query items:queryResultItems];    
    return queryResult;
}

- (DocumentDetail *)loadDocumentDetailOfDocument:(Document *)document withError:(NSError *__autoreleasing *)error {
    MockupDocumentBackendService *service = [[MockupDocumentBackendService alloc] init];
    DocumentDetail *documentDetail = [service documentDetailWithDocumentObjectID:document.dlObjectID];
    
    // Introduce artificial response time from Backend
    sleep(1);
    
    return documentDetail;
}

@end
