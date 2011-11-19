//
//  QueryServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryServiceImpl.h"
#import "MockupQueryImpl.h"
#import "ServiceFactory.h"

@implementation QueryServiceImpl

- (LibraryChoice *)currentLibraryChoice
{
    return [[[ServiceFactory sharedFactory] libraryService] libraryChoice];
}

- (id<Query>)buildQueryFromString:(NSString *)string
{
    // TODO Implementation needed
    MockupQueryImpl *query = [[MockupQueryImpl alloc] initWithString:string];
    query.selectedLibraries = [[[ServiceFactory sharedFactory] libraryService] libraryChoice].selectedLibraries;
    return query;
}

- (id<Query>)buildQueryFromParameters:(NSDictionary *)parameters
{
    // TODO Implementation needed
    MockupQueryImpl *query = [[MockupQueryImpl alloc] initWithParameters:parameters];
    query.selectedLibraries = [[[ServiceFactory sharedFactory] libraryService] libraryChoice].selectedLibraries;
    return query;
}

- (QueryResult *)executeQuery:(id<Query>)query withError:(NSError *)error
{
    return [[[ServiceFactory sharedFactory] backendService] executeQuery:query withError:error];
}

@end
