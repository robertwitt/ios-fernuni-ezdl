//
//  QueryResultItem.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultItem.h"

@implementation QueryResultItem

@synthesize document = _document;
@synthesize library = _library;
@synthesize relevance = _relevance;

+ (QueryResultItem *)queryResultItemWithDocument:(Document *)document library:(Library *)library relevance:(float)relevance
{
    QueryResultItem *item = [[QueryResultItem alloc] initWithDocument:document
                                                              library:library
                                                            relevance:relevance];
    return item;
}

- (id)initWithDocument:(Document *)document library:(Library *)library relevance:(float)relevance
{
    self = [self init];
    if (self)
    {
        _document = document;
        _library = library;
        _relevance = relevance;
    }
    return self;
}

@end
