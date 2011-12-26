//
//  QueryConnector.m
//  ezDL
//
//  Created by Robert Witt on 25.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryConnector.h"
#import "QueryGlobals.h"

@implementation QueryConnector

@synthesize identifier = _identifier;

+ (QueryConnector *)andConnector
{
    return [[QueryConnector alloc] initWithIdentifier:kQueryConnectorAnd];
}

+ (QueryConnector *)orConnector
{
    return [[QueryConnector alloc] initWithIdentifier:kQueryConnectorOr];
}

+ (QueryConnector *)connectorWithIdentifier:(NSString *)identifier
{
    return [[QueryConnector alloc] initWithIdentifier:identifier];
}

- (id)initWithIdentifier:(NSString *)identifier
{
    self = [self init];
    if (self) _identifier= identifier;
    return self;
}

- (NSString *)queryString
{
    return self.identifier;
}

@end
