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


@interface QueryParameter : NSObject <QueryPart>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic) enum QueryParameterOperator operator;
@property (nonatomic) BOOL isNot;
@property (nonatomic, strong, readonly) NSString *queryString;
@property (nonatomic, strong, readonly) NSString *queryStringWithoutKey;

+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value;
+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator;
+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator isNot:(BOOL)isNot;
- (id)initWithKey:(NSString *)key value:(NSString *)value;
- (id)initWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator;
- (id)initWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator isNot:(BOOL)isNot;

+ (enum QueryParameterOperator)operatorFromString:(NSString *)string;
+ (NSString *)operatorString:(enum QueryParameterOperator)operator;

@end
