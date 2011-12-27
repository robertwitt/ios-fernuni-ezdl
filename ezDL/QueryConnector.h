//
//  QueryConnector.h
//  ezDL
//
//  Created by Robert Witt on 25.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryPart.h"


static NSString *kQueryConnectorAnd = @"AND";
static NSString *kQueryConnectorOr = @"OR";


@interface QueryConnector : NSObject <QueryPart>

@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSString *queryString;

+ (QueryConnector *)andConnector;
+ (QueryConnector *)orConnector;
+ (QueryConnector *)connectorWithIdentifier:(NSString *)identifier;
- (id)initWithIdentifier:(NSString *)identifier;
- (BOOL)isAndConnector;
- (BOOL)isOrConnector;

@end
