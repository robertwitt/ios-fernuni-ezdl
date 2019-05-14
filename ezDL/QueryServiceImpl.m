//
//  QueryServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryServiceImpl.h"
#import "AdvancedQueryParser.h"
#import "BasicQueryParser.h"
#import "NestedQueryExpression.h"
#import "QuerySyntaxChecker.h"
#import "ServiceFactory.h"


@interface QueryServiceImpl ()

@property (nonatomic, weak, readonly) id<LibraryService> libraryService;

@end


@implementation QueryServiceImpl

- (id<LibraryService>)libraryService
{
    return [[ServiceFactory sharedFactory] libraryService];
}

- (LibraryChoice *)currentLibraryChoice {
    return [self.libraryService libraryChoice];
}

- (BOOL)checkQuerySyntaxFromString:(NSString *)string {
    QuerySyntaxChecker *syntaxChecker = [[QuerySyntaxChecker alloc] init];
    return [syntaxChecker checkString:string];
}

- (Query *)buildQueryFromString:(NSString *)string {
    Query *query = [[Query alloc] init];
    
    BasicQueryParser *parser = [BasicQueryParser parserWithString:string];
    query.baseExpression = [parser parsedExpressionWithError:nil];
    
    query.selectedLibraries = [self.libraryService libraryChoice].selectedLibraries;
    return query;
}

- (Query *)buildQueryFromParameters:(NSDictionary *)parameters {
    Query *query = [[Query alloc] init];
        
    query.baseExpression = [AdvancedQueryParser parsedExpressionFromParameters:parameters error:nil];    
    query.selectedLibraries = [self.libraryService libraryChoice].selectedLibraries;
    
    return query;
}

- (QueryResult *)executeQuery:(Query *)query withError:(NSError *__autoreleasing *)error {
    return [[[ServiceFactory sharedFactory] backendService] executeQuery:query withError:error];
}

@end
