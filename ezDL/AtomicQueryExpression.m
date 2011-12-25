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

- (BOOL)isDeep
{
    // An atomic query expression is never deep by definition
    return NO;
}

- (NSString *)parameterValueForKey:(NSString *)key
{
    NSString *value = nil;
    
    if ([self.parameter.key isEqualToString:key])
    {
        if (self.parameter.isNot) value = @"NOT ";
        value = [value stringByAppendingString:self.parameter.value];
    }
    
    return value;
}

- (NSString *)queryString
{
    return [self.parameter queryString];
}

@end
