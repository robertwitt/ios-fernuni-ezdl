//
//  BasicQueryParser.m
//  ezDL
//
//  Created by Robert Witt on 27.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicQueryParser.h"
#import "AtomicQueryExpression.h"
#import "NestedQueryExpression.h"
#import "QueryConnector.h"
#import "QueryParameter.h"
#import "QueryScanner.h"
#import "Stack.h"


@interface BasicQueryParser () <QueryScannerDelegate>

@property (nonatomic, strong) Stack *expressionStack;
@property (nonatomic, strong) NestedQueryExpression *nestedExpression;
@property (nonatomic, strong) NSMutableString *quoteBuffer;
@property (nonatomic) BOOL isInMiddleOfQuote;
@property (nonatomic, strong) NSString *parameterKey;
@property (nonatomic, strong) NSString *lastWord;
@property (nonatomic) BOOL didFoundOperator;
@property (nonatomic) BOOL isNot;
@property (nonatomic) enum QueryParameterOperator operator;
@property (nonatomic, strong) id<QueryExpression> resultExpression;

@end


@implementation BasicQueryParser

@synthesize queryString = _queryString;
@synthesize expressionStack = _expressionStack;
@synthesize nestedExpression = _nestedExpression;
@synthesize quoteBuffer = _quoteBuffer;
@synthesize isInMiddleOfQuote = _isInMiddleOfQuote;
@synthesize parameterKey = _parameterKey;
@synthesize lastWord = _lastWord;
@synthesize didFoundOperator = _didFoundOperator;
@synthesize isNot = _isNot;
@synthesize operator = _operator;
@synthesize resultExpression = _resultExpression;

+ (BasicQueryParser *)parserWithString:(NSString *)string {
    return [[BasicQueryParser alloc] initWithString:string];
}

- (id)initWithString:(NSString *)string {
    self = [self init];
    if (self) self.queryString = string;
    return self;
}

- (id<QueryExpression>)parsedExpressionWithError:(NSError *__autoreleasing *)error {
    QueryScanner *scanner = [QueryScanner scannerWithString:self.queryString];
    scanner.delegate = self;
    
    [scanner scan];
    
    return self.resultExpression;
}

- (void)scannerDidBeginScanning:(QueryScanner *)scanner {
    self.expressionStack = [[Stack alloc] init];
    self.nestedExpression = [[NestedQueryExpression alloc] init];
    self.isInMiddleOfQuote = NO;
    self.parameterKey = kQueryParameterKeyText;
    self.didFoundOperator = NO;
    self.isNot = NO;
    self.operator = QueryParameterOperatorEquals;
}

- (void)scannerDidEndScanning:(QueryScanner *)scanner {
    if (self.nestedExpression.parts.count == 1) {
        self.resultExpression = [self.nestedExpression.parts lastObject];
    } else {
        self.resultExpression = self.nestedExpression;
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundWord:(NSString *)word {
    if (self.isInMiddleOfQuote) {
        [self.quoteBuffer appendFormat:@" %@", word];
    } else {
        // Single word found. Create the atomic expression and save it to buffer.
        if (self.didFoundOperator) {
            // Operator has been found. This means we probably have saved a parameter key as value in the last scanner:didFoundWord: message. Delete it from self.nestedExpression.
            AtomicQueryExpression *atomicExpression = [self.nestedExpression.parts lastObject];
            self.isNot = atomicExpression.parameter.isNot;
            [self.nestedExpression removePart:atomicExpression];
            self.parameterKey = self.lastWord;
            self.didFoundOperator = NO;
        }
        
        AtomicQueryExpression *expression = [AtomicQueryExpression atomicExpressionWithParameterKey:self.parameterKey
                                                                                              value:word
                                                                                           operator:self.operator];
        expression.parameter.isNot = self.isNot;
        
        [self.nestedExpression addPart:expression];
        
        self.parameterKey = kQueryParameterKeyText;
        self.operator = QueryParameterOperatorEquals;
        
        // Cache the word, it could be a parameter key. We'll found out in next scanner:didFoundWord: message.
        self.lastWord = word;
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundQuoteSign:(NSString *)sign {
    if (!self.isInMiddleOfQuote) {
        // New quote started
        self.quoteBuffer = [NSMutableString string];
        self.isInMiddleOfQuote = YES;
    } else {
        // Quote ended. Push it to the buffer.
        if (self.didFoundOperator) {
            // Operator has been found. This means we probably have saved a parameter key as value in the last scanner:didFoundWord: message. Delete it from self.nestedExpression.
            [self.nestedExpression removePart:[self.nestedExpression.parts lastObject]];
            self.parameterKey = self.lastWord;
            self.didFoundOperator = NO;
        }
        
        AtomicQueryExpression *expression = [AtomicQueryExpression atomicExpressionWithParameterKey:self.parameterKey
                                                                                              value:[self.quoteBuffer trimmedString]
                                                                                           operator:self.operator];
        self.isInMiddleOfQuote = NO;
        self.parameterKey = kQueryParameterKeyText;
        self.operator = QueryParameterOperatorEquals;
        
        [self.nestedExpression addPart:expression];
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundConnector:(NSString *)connector {
    if (self.isInMiddleOfQuote) {
        [self.quoteBuffer appendFormat:@" %@", connector];
    } else {
        // Single operator found
        QueryConnector *connectorObject = [QueryConnector connectorWithIdentifier:connector];
        [self.nestedExpression addPart:connectorObject];
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundOperator:(NSString *)operator {
    if (self.isInMiddleOfQuote) {
        [self.quoteBuffer appendFormat:@" %@", operator];
    } else {
        // Operator sign found
        self.operator = [QueryParameter operatorFromString:operator];
        self.didFoundOperator = YES;
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundOpenBracket:(NSString *)bracket {
    if (self.isInMiddleOfQuote) {
        [self.quoteBuffer appendFormat:@" %@", bracket];
    } else {
        // Open bracket found. Push current expression buffer to stack and start with a new one.
        [self.expressionStack push:self.nestedExpression];
        self.nestedExpression = [[NestedQueryExpression alloc] init];
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundCloseBracket:(NSString *)bracket {
    if (self.isInMiddleOfQuote) {
        [self.quoteBuffer appendFormat:@" %@", bracket];
    } else {
        // Close bracket found
        NestedQueryExpression *lastExpression = [self.expressionStack pop];
        [lastExpression addPart:self.nestedExpression];
        self.nestedExpression = lastExpression;
    }
}

- (void)scanner:(QueryScanner *)scanner didFoundNotOperator:(NSString *)operator {
    if (self.isInMiddleOfQuote) {
        [self.quoteBuffer appendFormat:@" %@", operator];
    } else {
        // Operator sign found
        self.isNot = YES;
    }
}

@end
