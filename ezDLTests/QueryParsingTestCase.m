//
//  ezDLTests.m
//  ezDLTests
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryParsingTestCase.h"
#import "AdvancedQueryParser.h"
#import "QueryGlobals.h"
#import "QueryScanner.h"


@interface QueryParsingTestCase () <QueryScannerDelegate>

@property (nonatomic, strong) QueryScanner *scanner;
@property (nonatomic, strong) QueryParser *parser;
@property (nonatomic, strong) NSString *query1;
@property (nonatomic, strong) NSString *query2;
@property (nonatomic, strong) NSString *query3;

@end


@implementation QueryParsingTestCase

@synthesize scanner = _scanner;
@synthesize parser = _parser;
@synthesize query1 = _query1;
@synthesize query2 = _query2;
@synthesize query3 = _query3;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.query1 = @"Title=\"information retrieval\" AND (Title=search AND Author=Miller) OR Author=Smith AND NOT Year=2001";
    self.query2 = @"information AND search";
    self.query3 = @"\"information retrieval\" AND (search OR engine)";
    
    self.scanner = [QueryScanner scannerWithString:self.query1];
    self.scanner.delegate = self;
    
    self.parser = [AdvancedQueryParser parserWithValue:self.query3 key:kQueryParameterKeyTitle];
}

- (void)tearDown
{
    // Tear-down code here.
    self.scanner = nil;
    self.parser = nil;
    self.query1 = nil;
    self.query2 = nil;
    self.query3 = nil;
    
    [super tearDown];
}

- (void)testQueryScanning
{
    [self.scanner scan];
}

- (void)scanner:(QueryScanner *)scanner didFoundWord:(NSString *)word
{
    
}

- (void)scanner:(QueryScanner *)scanner didFoundOperator:(NSString *)operator
{
    
}

- (void)scanner:(QueryScanner *)scanner didFoundQuoteSign:(NSString *)sign
{
    
}

- (void)scanner:(QueryScanner *)scanner didFoundOpenBracket:(NSString *)bracket
{
    
}

- (void)scanner:(QueryScanner *)scanner didFoundCloseBracket:(NSString *)bracket
{
    
}

- (void)scanner:(QueryScanner *)scanner didFoundEqualsSign:(NSString *)sign
{
    
}

- (void)testQueryParsing
{
    id<QueryExpression> expression = [self.parser parsedExpressionWithError:nil];
}

@end
