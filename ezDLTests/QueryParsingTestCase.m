//
//  ezDLTests.m
//  ezDLTests
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryParsingTestCase.h"
#import "QueryParser.h"


@interface QueryParsingTestCase ()

@property (nonatomic, strong) QueryParser *parser;
@property (nonatomic, strong) NSString *query1;
@property (nonatomic, strong) NSString *query2;
@property (nonatomic, strong) NSString *query3;

@end


@implementation QueryParsingTestCase

@synthesize parser = _parser;
@synthesize query1 = _query1;
@synthesize query2 = _query2;
@synthesize query3 = _query3;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.parser = [[QueryParser alloc] init];
    self.query1 = @"Title=\"information retrieval\" AND (Title=search AND Author=Miller) OR Author=Smith AND NOT Year=2001";
    self.query2 = @"information";
    self.query3 = @"(Title=A AND (Author=1 OR Author=2)) AND Title=B";
}

- (void)tearDown
{
    // Tear-down code here.
    self.parser = nil;
    self.query1 = nil;
    self.query2 = nil;
    self.query3 = nil;
    
    [super tearDown];
}

- (void)testQueryParsing
{
    id<QueryExpression> parsedExpression = [self.parser parsedExpressionFromString:self.query1];
    NSLog(@"%@", [parsedExpression queryString]);
    
    parsedExpression = [self.parser parsedExpressionFromString:self.query2];
    NSLog(@"%@", [parsedExpression queryString]);
    
    parsedExpression = [self.parser parsedExpressionFromString:self.query3];
    NSLog(@"%@", [parsedExpression queryString]);
}

@end
