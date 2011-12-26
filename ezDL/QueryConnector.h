//
//  QueryConnector.h
//  ezDL
//
//  Created by Robert Witt on 25.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryPart.h"

@interface QueryConnector : NSObject <QueryPart>

@property (nonatomic, strong, readonly) NSString *identifier;

+ (QueryConnector *)andConnector;
+ (QueryConnector *)orConnector;
+ (QueryConnector *)connectorWithIdentifier:(NSString *)identifier;
- (id)initWithIdentifier:(NSString *)identifier;

@end
