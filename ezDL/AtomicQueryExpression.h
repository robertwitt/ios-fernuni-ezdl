//
//  AtomicQueryExpression.h
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExpression.h"
#import "QueryParameter.h"

/*!
 @class AtomicQueryExpression
 @abstract Atomic query expression in a query
 @discussion This class implements the QueryExpression protocol. It is a not dividable expression in a query, so it fulfills the leaf task in the composite pattern. The main property is a QueryParameter, a combination of a parameter key and value.
 */
@interface AtomicQueryExpression : NSObject <QueryExpression>

/*!
 @property parameter
 @abstract QueryParameter in the expression
 */
@property (nonatomic, strong) QueryParameter *parameter;

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

/*!
 @method atomicExpressionWithParameterKey:value:
 @abstract Convenience method to create an atomic expression
 @param key A parameter key
 @param value A parameter value
 @return The created AtomicQueryExpression object
 */
+ (AtomicQueryExpression *)atomicExpressionWithParameterKey:(NSString *)key value:(NSString *)value;

/*!
 @method atomicExpressionWithParameterKey:value:operator:
 @abstract Convenience method to create an atomic expression
 @param key A parameter key
 @param value A parameter value
 @param operator A QueryParameterOperator value
 @return The created AtomicQueryExpression object
 */
+ (AtomicQueryExpression *)atomicExpressionWithParameterKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator;

/*!
 @method initWithParameterKey:value:
 @abstract Initializes an atomic expression
 @param key A parameter key
 @param value A parameter value
 @return The created AtomicQueryExpression object
 */
- (id)initWithParameterKey:(NSString *)key value:(NSString *)value;

/*!
 @method initWithParameterKey:value:operator:
 @abstract Initializes an atomic expression
 @param key A parameter key
 @param value A parameter value
 @param operator A QueryParameterOperator value
 @return The created AtomicQueryExpression object
 */
- (id)initWithParameterKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator;

@end
