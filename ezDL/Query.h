//
//  Query.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExpression.h"

@protocol Query <NSObject>

- (id<QueryExpression>)baseExpression;
- (void)setBaseExpression:(id<QueryExpression>)baseExpression;
- (NSArray *)selectedLibraries;
- (void)setSelectedLibraries:(NSArray *)selectedLibraries;
- (NSDate *)executedOn;
- (void)setExecutedOn:(NSDate *)executedOn;
- (NSArray *)parameterValues;
- (NSString *)parameterValueFromKey:(NSString *)key;
- (NSString *)queryString;

@end
