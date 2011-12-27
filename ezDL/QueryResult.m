//
//  QueryResult.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResult.h"

@implementation QueryResult

@synthesize query = _query;
@synthesize items = _items;

+ (QueryResult *)queryResultWithQuery:(Query *)query items:(NSArray *)items
{
    return [[QueryResult alloc] initWithQuery:query items:items];
}

- (id)initWithQuery:(Query *)query items:(NSArray *)items
{
    self = [self init];
    if (self)
    {
        _query = query;
        _items = items;
    }
    return self;
}

@end
