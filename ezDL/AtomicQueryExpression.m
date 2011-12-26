//
//  AtomicQueryExpression.m
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AtomicQueryExpression.h"

@implementation AtomicQueryExpression

@synthesize parameter = _parameter;

+ (AtomicQueryExpression *)atomicExpressionWithParameterKey:(NSString *)key value:(NSString *)value
{
    return [[AtomicQueryExpression alloc] initWithParameterKey:key value:value];
}

+ (AtomicQueryExpression *)atomicExpressionWithParameterKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator
{
    return [[AtomicQueryExpression alloc] initWithParameterKey:key value:value operator:operator];
}

- (id)initWithParameterKey:(NSString *)key value:(NSString *)value
{
    return [[AtomicQueryExpression alloc] initWithParameterKey:key value:value operator:QueryParameterOperatorEquals];
}

- (id)initWithParameterKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator
{
    self = [self init];
    if (self)
    {
        self.parameter = [QueryParameter parameterWithKey:key 
                                                    value:value
                                                 operator:operator];
    }
    return self;
}

- (BOOL)isDeep
{
    // An atomic query expression is never deep by definition
    return NO;
}

- (NSString *)parameterValueForKey:(NSString *)key
{
    // TODO Implementation needed
    
    return nil;
}

- (NSString *)queryString
{
    return [self.parameter queryString];
}

@end
