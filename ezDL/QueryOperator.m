//
//  QueryOperator.m
//  ezDL
//
//  Created by Robert Witt on 25.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryOperator.h"
#import "QueryGlobals.h"

@implementation QueryOperator

@synthesize key = _key;

+ (QueryOperator *)andOperator
{
    return [[QueryOperator alloc] initWithKey:QueryOperatorKeyAnd];
}

+ (QueryOperator *)orOperator
{
    return [[QueryOperator alloc] initWithKey:QueryOperatorKeyOr];
}

- (id)initWithKey:(enum QueryOperatorKey)key
{
    self = [self init];
    if (self) _key = key;
    return self;
}

- (NSString *)queryString
{
    NSString *queryString = nil;
    switch (self.key) {
        case QueryOperatorKeyAnd:
            queryString = kQueryOperatorAnd;
            break;
        case QueryOperatorKeyOr:
            queryString = kQueryOperatorOr;
            break;
    }
    return queryString;
}

@end
