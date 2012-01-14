//
//  QueryExpression.h
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryPart.h"

/*!
 @protocol QueryExpression
 @abstract Generic interface of a query expression
 @discussion This protocol defines an interface for an expression in a query. This could be either an atomic expression or a nested expression. It fulfills the task of the component in the composite design pattern.
 A query expression is more specific than a query part, therefore it extends this protocol.
 */
@protocol QueryExpression <QueryPart>

/*!
 @method isDeep
 @abstract Returns true if this expression is deep, i. e. if it is nested.
 @return True if the expression is nested, otherwise false
 */
- (BOOL)isDeep;

/*!
 @method parameterValueForKey:
 @abstract Returns the parameter value by a given key as string
 @param key A parameter key (see QueryParameter.h)
 @return Parameter value as string
 */
- (NSString *)parameterValueForKey:(NSString *)key;

@optional

/*!
 @method addPart:
 @abstract Adds a query part to this expression.
 @param part A query part
 */
- (void)addPart:(id<QueryPart>)part;

/*!
 @method removePart:
 @abstract Removes a query part to this expression.
 @param part A query part
 */
- (void)removePart:(id<QueryPart>)part;

@end
