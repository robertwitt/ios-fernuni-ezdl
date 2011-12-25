//
//  QueryParser.m
//  ezDL
//
//  Created by Robert Witt on 25.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryParser.h"
#import "AtomicQueryExpression.h"
#import "NestedQueryExpression.h"
#import "QueryGlobals.h"
#import "QueryOperator.h"


@interface QueryParser ()

- (BOOL)stringIsAtomicExpression:(NSString *)string;
- (AtomicQueryExpression *)atomicExpressionFromString:(NSString *)string;
- (NestedQueryExpression *)nestedExpressionFromString:(NSString *)string;

- (NSArray *)separateString:(NSString *)string by:(NSString *)separator;
- (NSString *)parameterKeyByString:(NSString *)string;
- (void)setParameterKey:(NSString *)parameterKey inExpression:(id<QueryExpression>)expression;

@end


@implementation QueryParser

- (id<QueryExpression>)parsedExpressionFromString:(NSString *)string
{
    id<QueryExpression> expression = [self atomicExpressionFromString:string];
    
    // If expression is nil, string must represent a nested query expression
    if (!expression) expression = [self nestedExpressionFromString:string];
    
    return expression;
}

- (BOOL)stringIsAtomicExpression:(NSString *)string
{
    BOOL atomic = NO;
    if ([self atomicExpressionFromString:string]) atomic = YES;
    return atomic;
}

- (AtomicQueryExpression *)atomicExpressionFromString:(NSString *)string
{
    AtomicQueryExpression *expression = nil;
    
    // Case 1: string is a quoted string literal with parameter key, example: Title="information retrieval"
    // Case 2: string is a single word with a parameter key, example: Title=search
    // Case 3: string is a single word, example: search
    // Case 4: string is a quoted string literal, example: "information retrieval"
    
    // Devide the string by equals sign (=) to check if it's a named parameter
    NSArray *substrings = [string componentsSeparatedByString:@"="];
    
    if (substrings.count == 2)
    {
        // string could be a named parameter. Get the key and value.
        NSString *parameterKey = [substrings objectAtIndex:0];
        NSString *parameterValue = [substrings objectAtIndex:1];
        BOOL parameterIsNot = NO;
        
        // parameterKey could be prefixed with NOT operator. Find that out.
        NSArray *parameterKeySubstrings = [parameterKey componentsSeparatedByString:@" "];
        if (parameterKeySubstrings.count == 2)
        {
            parameterIsNot = [[parameterKeySubstrings objectAtIndex:0] isEqualToString:kQueryOperatorNot];
            parameterKey = [parameterKeySubstrings objectAtIndex:1];
        }        
        parameterKey = [self parameterKeyByString:parameterKey];
        
        if (parameterKey && ([parameterValue isWord] || [parameterValue isQuote]))
        {
            // We have a valid atomic expression. Create the parameter and the expression.
            QueryParameter *parameter = [[QueryParameter alloc] init];
            parameter.key = parameterKey;
            parameter.value = parameterValue;
            parameter.isNot = parameterIsNot;
            
            expression = [[AtomicQueryExpression alloc] init];
            expression.parameter = parameter;
        }
    }
    else if (substrings.count == 1)
    {
        NSString *parameterValue = string;
        BOOL parameterIsNot = NO;
        
        // parameterKey could be prefixed with NOT operator. Find that out.
        NSArray *parameterValueSubstrings = [parameterValue componentsSeparatedByString:@" "];
        if (parameterValueSubstrings.count == 2)
        {
            parameterIsNot = [[parameterValueSubstrings objectAtIndex:0] isEqualToString:kQueryOperatorNot];
            parameterValue = [parameterValueSubstrings objectAtIndex:1];
        }
        
        if ([parameterValue isWord] || [parameterValue isQuote])
        {
            // We have a valid atomic expression. Create the parameter and the expression.
            QueryParameter *parameter = [[QueryParameter alloc] init];
            parameter.key = kQueryParameterKeyText;
            parameter.value = parameterValue;
            parameter.isNot = parameterIsNot;
            
            expression = [[AtomicQueryExpression alloc] init];
            expression.parameter = parameter;
        }
    }
    else
    {
        // If there are more than two substrings, string is not atomic. Do nothing here and let the method return nil
        expression = nil;
    }
    
    return expression;
}

- (NestedQueryExpression *)nestedExpressionFromString:(NSString *)string
{
    NestedQueryExpression *expression = [[NestedQueryExpression alloc] init];
    
    NSArray *stringsByAnd = [self separateString:string by:kQueryOperatorAnd];
    for (int i = 0; i < stringsByAnd.count; i++)
    {
        NSString *stringByAnd = [stringsByAnd objectAtIndex:i];
        
        if (i > 0) [expression addPart:[QueryOperator andOperator]];
        
        AtomicQueryExpression *atomicExpression = [self atomicExpressionFromString:stringByAnd];
        if (atomicExpression) 
        {
            [expression addPart:atomicExpression];
        }
        else
        {
            NestedQueryExpression *orExpression = [[NestedQueryExpression alloc] init];
            
            // stringByAnd contains itself a neste expression. Split by OR now.
            NSArray *stringsByOr = [self separateString:stringByAnd by:kQueryOperatorOr];
            for (int j = 0; j < stringsByOr.count; j++)
            {
                NSString *stringByOr = [stringsByOr objectAtIndex:j];
                
                if (j > 0) [orExpression addPart:[QueryOperator orOperator]];
                
                AtomicQueryExpression *atomicExpression = [self atomicExpressionFromString:stringByOr];
                if (atomicExpression)
                {
                    [orExpression addPart:atomicExpression];
                }
                else
                {
                    // Assumption: stringByOr contains a nested expression encapsulated in brackets. Dismiss the first and last characters.
                    NSRange range = NSMakeRange(1, stringByOr.length - 2);
                    NestedQueryExpression *nestedExpression = [self nestedExpressionFromString:[stringByOr substringWithRange:range]];
                    [orExpression addPart:nestedExpression];
                }
            }
            
            [expression addPart:orExpression];
        }
    }
    
    return expression;
}

- (NSArray *)separateString:(NSString *)string by:(NSString *)separator
{
    NSMutableArray *separatedStrings = [NSMutableArray array];
    NSInteger counter = 0;
    NSMutableString *buffer = [NSMutableString string];
    
    NSArray *substrings = [string componentsSeparatedByString:separator];
    for (NSString *substring in substrings)
    {        
        for (int i = 0; i < substring.length; i++)
        {
            unichar character = [substring characterAtIndex:i];
            switch (character)
            {
                case '(':
                    counter++;
                    break;
                case ')':
                    counter--;
                    break;
            }
            
            NSRange range = NSMakeRange(i, 1);
            [buffer appendString:[substring substringWithRange:range]];
        }
        
        if (counter == 0)
        {
            // No brackets found or all brackets have been closed. buffer is a separated string.
            [separatedStrings addObject:[buffer trimmedString]];
            buffer = [NSMutableString string];
        }
        else
        {
            // Still open brackets. Append the separator and continue with buffer.
            [buffer appendString:separator];
        }
    }
    
    if (counter > 0)
    {
        // If we still got uneven bracket pairs, there has to be something wrong
        NSString *name = [NSString stringWithFormat:@"QueryParserSyntaxException when separating string: %@", string];
        QueryParserSyntaxException *exception = [[QueryParserSyntaxException alloc] initWithName:name
                                                                                          reason:@"Open brackets aren't closed."
                                                                                        userInfo:nil];
        @throw exception;
    }
    
    return separatedStrings;
}

- (NSString *)parameterKeyByString:(NSString *)string
{
    NSString *parameterKey = nil;
    if ([string isEqualToString:kQueryParameterKeyAuthor]) parameterKey = string;
    if ([string isEqualToString:kQueryParameterKeyText]) parameterKey = string;
    if ([string isEqualToString:kQueryParameterKeyTitle]) parameterKey = string;
    if ([string isEqualToString:kQueryParameterKeyYear]) parameterKey = string;
    return parameterKey;
}

- (id<QueryExpression>)parsedExpressionFromParameters:(NSDictionary *)parameters
{
    NSMutableArray *expressions = [NSMutableArray array];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        id<QueryExpression> expression = [self parsedExpressionFromString:obj];
        [self setParameterKey:key inExpression:expression];
        [expressions addObject:expression];
    }];
    
    if (expressions.count == 1) return [expressions lastObject];
    
    NestedQueryExpression *nestedExpression = [[NestedQueryExpression alloc] init];
    [expressions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx > 0) [nestedExpression addPart:[QueryOperator andOperator]];
        [nestedExpression addPart:obj];
    }];
    return nestedExpression;
}

- (void)setParameterKey:(NSString *)parameterKey inExpression:(id<QueryExpression>)expression
{
    if ([expression isKindOfClass:NSClassFromString(@"AtomicQueryExpression")]) 
    {
        AtomicQueryExpression *atomicExpression = (AtomicQueryExpression *)expression;
        atomicExpression.parameter.key = parameterKey;
    }
    else
    {
        // expression must be nested
        NestedQueryExpression *nestedExpression = (NestedQueryExpression *)expression;
        [nestedExpression.parts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj conformsToProtocol:NSProtocolFromString(@"QueryExpression")]) [self setParameterKey:parameterKey inExpression:obj];
        }];
    }
}

@end


@implementation QueryParserException
@end

@implementation QueryParserSyntaxException
@end
