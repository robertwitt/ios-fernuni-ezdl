//
//  Query.m
//  ezDL
//
//  Created by Robert Witt on 27.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Query.h"

@implementation Query

@synthesize baseExpression = _baseExpression;
@synthesize selectedLibraries = _selectedLibraries;
@synthesize executedOn = _executedOn;

- (NSString *)queryString {
    NSString *string = [self.baseExpression queryString];
    
    // If string is surrounded by brackets, remove them
    if ([string characterAtIndex:0] == '(' && [string characterAtIndex:(string.length - 1)] == ')') {
        NSRange range = NSMakeRange(1, string.length - 2);
        string = [string substringWithRange:range];
    }
    
    return string;
}

- (NSString *)parameterValueFromKey:(NSString *)key {
    return [self.baseExpression parameterValueForKey:key];
}

@end
