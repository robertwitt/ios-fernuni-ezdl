//
//  QueryServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryServiceImpl.h"
#import "AdvancedQueryParser.h"
#import "MockupQueryImpl.h"
#import "NestedQueryExpression.h"
#import "ServiceFactory.h"

@implementation QueryServiceImpl

- (LibraryChoice *)currentLibraryChoice
{
    return [[[ServiceFactory sharedFactory] libraryService] libraryChoice];
}

- (id<Query>)buildQueryFromString:(NSString *)string
{
    MockupQueryImpl *query = [[MockupQueryImpl alloc] init];
    
    //SimpleQueryParser *parser = [[SimpleQueryParser alloc] init];
    //query.baseExpression = [parser parsedExpressionFromString:string];
    
    query.selectedLibraries = [[[ServiceFactory sharedFactory] libraryService] libraryChoice].selectedLibraries;
    return query;
}

- (id<Query>)buildQueryFromParameters:(NSDictionary *)parameters
{
    MockupQueryImpl *query = [[MockupQueryImpl alloc] init];
        
    query.baseExpression = [AdvancedQueryParser parsedExpressionFromParameters:parameters error:nil];
    //SimpleQueryParser *parser = [[SimpleQueryParser alloc] init];
    //query.baseExpression = [parser parsedExpressionFromParameters:parameters];
    
    query.selectedLibraries = [[[ServiceFactory sharedFactory] libraryService] libraryChoice].selectedLibraries;
    return query;
}

- (QueryResult *)executeQuery:(id<Query>)query withError:(NSError *__autoreleasing *)error
{
    return [[[ServiceFactory sharedFactory] backendService] executeQuery:query withError:error];
}

@end
