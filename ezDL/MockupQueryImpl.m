//
//  MockupQueryImpl.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MockupQueryImpl.h"

@implementation MockupQueryImpl

@synthesize baseExpression = _baseExpression;
@synthesize selectedLibraries = _selectedLibraries;
@synthesize executedOn = _executedOn;

- (id)initWithString:(NSString *)string
{
    self = [self init];
    if (self) 
    {
        // TODO Implementation needed
    }
    return self;
}

- (id)initWithParameters:(NSDictionary *)parameters
{
    self = [self init];
    if (self) 
    {
        // TODO Implementation needed
    }
    return self;
}

- (id<QueryExpression>)baseExpression
{
    return _baseExpression;
}

- (void)setBaseExpression:(id<QueryExpression>)baseExpression
{
    _baseExpression = baseExpression;
}

- (NSArray *)selectedLibraries
{
    return _selectedLibraries;
}

- (void)setSelectedLibraries:(NSArray *)selectedLibraries
{
    _selectedLibraries = selectedLibraries;
}

- (NSDate *)executedOn
{
    return _executedOn;
}

- (void)setExecutedOn:(NSDate *)executedOn
{
    _executedOn = executedOn;
}

- (NSArray *)parameterValues
{
    // TODO Implementation needed
    return [NSArray arrayWithObjects:@"information", @"retrieval", @"search", nil];
}

- (NSString *)parameterValueFromKey:(NSString *)key
{
    // TODO Implementation needed
    return nil;
}

- (NSString *)queryString
{
    NSString *string = [self.baseExpression queryString];
    
    // If string is surrounded by brackets, remove them
    if ([string characterAtIndex:0] == '(' && [string characterAtIndex:(string.length - 1)] == ')')
    {
        NSRange range = NSMakeRange(1, string.length - 2);
        string = [string substringWithRange:range];
    }
    
    return string;
}

@end
