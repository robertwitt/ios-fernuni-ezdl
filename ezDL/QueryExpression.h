//
//  QueryExpression.h
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryPart.h"

@protocol QueryExpression <QueryPart>

- (BOOL)isDeep;
- (NSString *)parameterValueForKey:(NSString *)key;

@optional
- (void)addPart:(id<QueryPart>)part;
- (void)removePart:(id<QueryPart>)part;

@end
