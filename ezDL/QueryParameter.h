//
//  QueryParameter.h
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryPart.h"


static NSString *kQueryParameterKeyAuthor = @"Author";
static NSString *kQueryParameterKeyText = @"Text";
static NSString *kQueryParameterKeyTitle = @"Title";
static NSString *kQueryParameterKeyYear = @"Year";

static NSString *kQueryOperatorNot = @"NOT";

enum QueryParameterOperator {
    QueryParameterOperatorEquals,
    QueryParameterOperatorLessThan,
    QueryParameterOperatorLessOrEquals,
    QueryParameterOperatorGreaterThan,
    QueryParameterOperatorGreaterOrEquals
};


/*!
 @class QueryParameter
 @abstract Parameter in an atomic expression
 @discussion A query parameter is a key/value combination, concatenated by a QueryParameterOperator value.
 */
@interface QueryParameter : NSObject <QueryPart>

/*!
 @property key
 @abstract The key of this parameter as string.
 */
@property (nonatomic, strong) NSString *key;

/*!
 @property value
 @abstract The value of this parameter as string.
 */
@property (nonatomic, strong) NSString *value;

/*!
 @property operator
 @abstract The operator of this parameter as QueryParameterOperator value.
 */
@property (nonatomic) enum QueryParameterOperator operator;

/*!
 @property isNot
 @abstract This flag indicates if the parameter is negated.
 */
@property (nonatomic) BOOL isNot;

/*!
 @property queryString
 @abstract String representation of this QueryPart
 */
@property (nonatomic, strong, readonly) NSString *queryString;

/*!
 @property queryStringWithoutKey
 @abstract String representation of this parameter without the key
 */
@property (nonatomic, strong, readonly) NSString *queryStringWithoutKey;

/*!
 @method parameterWithKey:value:
 @abstract Convenience method to create a QueryParameter object
 @param key The query parameter's key
 @param value The query parameter's value
 @return The created QueryParameter object
 */
+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value;

/*!
 @method parameterWithKey:value:operator:
 @abstract Convenience method to create a QueryParameter object
 @param key The query parameter's key
 @param value The query parameter's value
 @param operator The query parameter's operator
 @return The created QueryParameter object
 */
+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator;

/*!
 @method parameterWithKey:value:operator:isNot:
 @abstract Convenience method to create a QueryParameter object
 @param key The query parameter's key
 @param value The query parameter's value
 @param operator The query parameter's operator
 @param isNot The query parameter's negation flag
 @return The created QueryParameter object
 */
+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator isNot:(BOOL)isNot;

/*!
 @method initWithKey:value:
 @abstract Initializes a QueryParameter object
 @param key The query parameter's key
 @param value The query parameter's value
 @return The created QueryParameter object
 */
- (id)initWithKey:(NSString *)key value:(NSString *)value;

/*!
 @method initWithKey:value:operator:
 @abstract Initializes a QueryParameter object
 @param key The query parameter's key
 @param value The query parameter's value
 @param operator The query parameter's operator
 @return The created QueryParameter object
 */
- (id)initWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator;

/*!
 @method initWithKey:value:operator:isNot:
 @abstract Initializes a QueryParameter object
 @param key The query parameter's key
 @param value The query parameter's value
 @param operator The query parameter's operator
 @param isNot The query parameter's negation flag
 @return The created QueryParameter object
 */
- (id)initWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator isNot:(BOOL)isNot;

/*!
 @method operatorFromString:
 @abstract Returns QueryParameterOperator value by a string
 @param string A query string
 @return A QueryParameterOperator value
 */
+ (enum QueryParameterOperator)operatorFromString:(NSString *)string;

/*!
 @method operatorString:
 @abstract Returns a string representation of a given QueryParameterOperator value
 @param operator A QueryParameterOperator value
 @return A query string
 */
+ (NSString *)operatorString:(enum QueryParameterOperator)operator;

@end
