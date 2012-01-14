//
//  NestedQueryExpression.h
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExpression.h"

/*!
 @class NestedQueryExpression
 @abstract Nested query expression in a query
 @discussion This class implements the QueryExpression protocol. It is a dividable expression in a query, so it fulfills the compositum task in the composite pattern. It collects an array of QueryPart instances.
 */
@interface NestedQueryExpression : NSObject <QueryExpression>

/*!
 @property parts
 @abstract Array of QueryPart instances
 */
@property (nonatomic, strong, readonly) NSArray *parts;

/*!
 @property queryString
 @abstract String representation of this QueryPart
 */
@property (nonatomic, strong, readonly) NSString *queryString;

/*!
 @property deep
 @abstract True if the expression is nested, otherwise false
 */
@property (nonatomic, readonly, getter=isDeep) BOOL deep;

@end
