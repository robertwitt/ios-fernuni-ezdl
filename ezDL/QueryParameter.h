//
//  QueryParameter.h
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryPart.h"


enum QueryParameterOperator {
    QueryParameterOperatorEquals,
    QueryParameterOperatorNotEquals,
    QueryParameterOperatorLessThan,
    QueryParameterOperatorLessOrEquals,
    QueryParameterOperatorGreaterThan,
    QueryParameterOperatorGreaterOrEquals
};

@interface QueryParameter : NSObject <QueryPart>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic) enum QueryParameterOperator operator;

+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value;
+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator;
- (id)initWithKey:(NSString *)key value:(NSString *)value;
- (id)initWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator;

+ (enum QueryParameterOperator)operatorFromString:(NSString *)string;
+ (NSString *)operatorString:(enum QueryParameterOperator)operator;

@end
