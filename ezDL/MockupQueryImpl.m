//
//  MockupQueryImpl.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MockupQueryImpl.h"

@implementation MockupQueryImpl

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
    // TODO Implementation needed
    return nil;
}

@end
