//
//  NestedQueryExpression.m
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NestedQueryExpression.h"
#import "QueryConnector.h"


@interface NestedQueryExpression ()

@property (nonatomic, strong) NSMutableArray *mutableParts;

@end


@implementation NestedQueryExpression

@synthesize mutableParts = _mutableParts;

- (NSMutableArray *)mutableParts {
    if (!_mutableParts) _mutableParts = [NSMutableArray array];
    return _mutableParts;
}

- (NSArray *)parts {
    return self.mutableParts;
}

- (void)addPart:(id<QueryPart>)part {
    Class connectorClass = [QueryConnector class];
    if (self.mutableParts.notEmpty && ![part isKindOfClass:connectorClass] && ![[self.mutableParts lastObject] isKindOfClass:connectorClass]) {
        // Append AND connector
        [self.mutableParts addObject:[QueryConnector andConnector]];
    }
    
    [self.mutableParts addObject:part];
}

- (void)removePart:(id<QueryPart>)part {
    [self.mutableParts removeObject:part];
}

- (BOOL)isDeep {
    __block BOOL deep = NO;
    [self.parts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NestedQueryExpression class]] || ([obj isKindOfClass:[QueryConnector class]] && ![obj isAndConnector])) {
            // obj is either a nested expression or it is a connector different than AND. Then this nested expression is defined as deep.
            deep = YES;
            *stop = YES;
        }
    }];
     
    return deep;
}

- (NSString *)parameterValueForKey:(NSString *)key
{
    NSString *value = @"";
    
    if (![self isDeep]) {
        // Only return values if the expression isn't deep
        NSMutableArray *expressions = [NSMutableArray array];
        [self.parts enumerateObjectsUsingBlock:^(id<QueryPart> obj, NSUInteger idx, BOOL *stop) {
            if ([obj conformsToProtocol:NSProtocolFromString(@"QueryExpression")]) {
                // obj is an expression
                NSString *localValue = [(id<QueryExpression>)obj parameterValueForKey:key];
                if (localValue.notEmpty) [expressions addObject:localValue];
            }
        }];
        
        // Concatenate all expressions by AND
        value = [expressions componentsJoinedByString:[NSString stringWithFormat:@" %@ ", kQueryConnectorAnd]];
    }
    
    return value;
}

- (NSString *)queryString {
    NSMutableString *string = [NSMutableString stringWithString:@"("];
    
    [self.parts enumerateObjectsUsingBlock:^(id<QueryPart> obj, NSUInteger idx, BOOL *stop) {
        if (idx != 0) [string appendString:@" "];
        [string appendString:[obj queryString]];
    }];
    
    [string appendString:@")"];
    
    return string;
}

@end
