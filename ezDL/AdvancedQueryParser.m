//
//  AdvancedQueryParser.m
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AdvancedQueryParser.h"
#import "AtomicQueryExpression.h"
#import "NestedQueryExpression.h"
#import "QueryGlobals.h"
#import "QueryConnector.h"
#import "QueryScanner.h"
#import "Stack.h"


@interface AdvancedQueryParser () <QueryScannerDelegate>

@property (nonatomic, strong) Stack *expressionStack;
@property (nonatomic, strong) NestedQueryExpression *nestedExpression;
@property (nonatomic, strong) NSMutableString *quoteBuffer;
@property (nonatomic) BOOL isInMiddleOfQuote;
@property (nonatomic) enum QueryParameterOperator operator;
@property (nonatomic, strong) id<QueryExpression> resultExpression;

@end


@implementation AdvancedQueryParser

@synthesize parameterKey = _parameterKey;
@synthesize parameterValue = _parameterValue;
@synthesize expressionStack = _expressionStack;
@synthesize nestedExpression = _nestedExpression;
@synthesize quoteBuffer = _quoteBuffer;
@synthesize isInMiddleOfQuote = _isInMiddleOfQuote;
@synthesize operator = _operator;
@synthesize resultExpression = _resultExpression;

+ (id<QueryExpression>)parsedExpressionFromParameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error
{
    __block NSError *err = nil;
    NestedQueryExpression *nestedExpression = [[NestedQueryExpression alloc] init];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {        
        AdvancedQueryParser *parser = [AdvancedQueryParser parserWithValue:(NSString *)obj key:(NSString *)key];
        id<QueryExpression> expression = [parser parsedExpressionWithError:&err];
        
        if (err) *stop = YES;
        [nestedExpression addPart:expression];
    }];
    
    if (err)
    {
        *error = err;
        return nil;
    }
    
    if (nestedExpression.parts.count == 1) return [nestedExpression.parts lastObject];
    else return nestedExpression;
}

+ (AdvancedQueryParser *)parserWithValue:(NSString *)value key:(NSString *)key
{
    return [[AdvancedQueryParser alloc] initWithParameterValue:value key:key];
}

- (id)initWithParameterValue:(NSString *)value key:(NSString *)key
{
    self = [self init];
    if (self)
    {
        self.parameterKey = key;
        self.parameterValue = value;
    }
    return self;
}

- (id<QueryExpression>)parsedExpressionWithError:(NSError *__autoreleasing *)error
{
    QueryScanner *scanner = [QueryScanner scannerWithString:self.parameterValue];
    scanner.delegate = self;
    
    [scanner scan];
    
    return self.resultExpression;
}

- (void)scannerDidBeginScanning:(QueryScanner *)scanner
{
    self.expressionStack = [[Stack alloc] init];
    self.nestedExpression = [[NestedQueryExpression alloc] init];
    self.isInMiddleOfQuote = NO;
    self.operator = QueryParameterOperatorEquals;
}

- (void)scannerDidEndScanning:(QueryScanner *)scanner
{
    if (self.nestedExpression.parts.count == 1) self.resultExpression = [self.nestedExpression.parts lastObject];
    else self.resultExpression = self.nestedExpression;
}

- (void)scanner:(QueryScanner *)scanner didFoundWord:(NSString *)word
{
    if (self.isInMiddleOfQuote)
    {
        [self.quoteBuffer appendFormat:@" %@", word];
    }
    else
    {
        // Single word found. Create the atomic expression and save it to buffer.
        AtomicQueryExpression *expression = [AtomicQueryExpression atomicExpressionWithParameterKey:self.parameterKey
                                                                                              value:word
                                                                                           operator:self.operator];
        self.operator = QueryParameterOperatorEquals;
        
        [self.nestedExpression addPart:expression];
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundQuoteSign:(NSString *)sign
{
    if (!self.isInMiddleOfQuote)
    {
        // New quote started
        self.quoteBuffer = [NSMutableString string];
        self.isInMiddleOfQuote = YES;
    }
    else
    {
        // Quote ended. Push it to the buffer.
        AtomicQueryExpression *expression = [AtomicQueryExpression atomicExpressionWithParameterKey:self.parameterKey
                                                                                              value:[self.quoteBuffer trimmedString]
                                                                                           operator:self.operator];
        self.isInMiddleOfQuote = NO;
        self.operator = QueryParameterOperatorEquals;
        
        [self.nestedExpression addPart:expression];
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundConnector:(NSString *)connector
{
    if (self.isInMiddleOfQuote)
    {
        [self.quoteBuffer appendFormat:@" %@", connector];
    }
    else
    {
        // Single operator found
        QueryConnector *connectorObject = [QueryConnector connectorWithIdentifier:connector];
        [self.nestedExpression addPart:connectorObject];
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundOpenBracket:(NSString *)bracket
{
    if (self.isInMiddleOfQuote)
    {
        [self.quoteBuffer appendFormat:@" %@", bracket];
    }
    else
    {
        // Open bracket found. Push current expression buffer to stack and start with a new one.
        [self.expressionStack push:self.nestedExpression];
        self.nestedExpression = [[NestedQueryExpression alloc] init];
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundCloseBracket:(NSString *)bracket
{
    if (self.isInMiddleOfQuote)
    {
        [self.quoteBuffer appendFormat:@" %@", bracket];
    }
    else
    {
        // Close bracket found
        NestedQueryExpression *lastExpression = [self.expressionStack pop];
        [lastExpression addPart:self.nestedExpression];
        self.nestedExpression = lastExpression;
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundOperator:(NSString *)operator
{
    if (self.isInMiddleOfQuote)
    {
        [self.quoteBuffer appendFormat:@" %@", operator];
    }
    else
    {
        // Operator sign found
        self.operator = [QueryParameter operatorFromString:operator];
    }
}

@end
