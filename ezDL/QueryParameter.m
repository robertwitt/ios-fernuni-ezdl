//
//  QueryParameter.m
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryParameter.h"


@implementation QueryParameter

@synthesize key = _key;
@synthesize value = _value;
@synthesize operator = _operator;
@synthesize isNot = _isNot;

+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value {
    return [[QueryParameter alloc] initWithKey:key value:value];
}

+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator {
    return [[QueryParameter alloc] initWithKey:key value:value operator:operator];
}

+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator isNot:(BOOL)isNot {
    return [[QueryParameter alloc] initWithKey:key value:value operator:operator isNot:isNot];
}

- (id)initWithKey:(NSString *)key value:(NSString *)value {
    return [[QueryParameter alloc] initWithKey:key value:value operator:QueryParameterOperatorEquals];
}

- (id)initWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator {
    return [[QueryParameter alloc] initWithKey:key value:value operator:operator isNot:NO];
}

- (id)initWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator isNot:(BOOL)isNot {
    self = [self init];
    if (self) {
        self.key = key;
        self.value = value;
        self.operator = operator;
        self.isNot = isNot;
    }
    return self;
}

- (NSString *)queryString
{
    NSString *string = @"";
    
    if (self.key.notEmpty && ![self.key isEqualToString:kQueryParameterKeyText]) {
        // self is a parameter with one of the following keys: Author, Title, Year
        if (self.isNot) string = [kQueryOperatorNot stringByAppendingString:@" "];
        string = [string stringByAppendingFormat:@"%@%@%@", self.key, [QueryParameter operatorString:self.operator], self.value];
    }
    else {
        string = self.queryStringWithoutKey;
    }
    
    return string;
}

- (NSString *)queryStringWithoutKey
{
    NSString *string = @"";
    if (self.isNot) string = [kQueryOperatorNot stringByAppendingString:@" "];
    
    if (self.operator == QueryParameterOperatorEquals) {
        string = [string stringByAppendingString:self.value];
    }
    else {
        string = [string stringByAppendingFormat:@"%@%@", [QueryParameter operatorString:self.operator], self.value];
    }
    return string;
}

+ (enum QueryParameterOperator)operatorFromString:(NSString *)string {
    if ([string isEqualToString:@">="]) return QueryParameterOperatorGreaterOrEquals;
    else if ([string isEqualToString:@">"]) return QueryParameterOperatorGreaterThan;
    else if ([string isEqualToString:@"<="]) return QueryParameterOperatorLessOrEquals;
    else if ([string isEqualToString:@"<"]) return QueryParameterOperatorLessThan;
    else return QueryParameterOperatorEquals;
    
    // If we got this far, string doesn't represent a valid operator. Throw exception.
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"%@ isn't a valid query parameter operator", string]
                                 userInfo:nil];
}

+ (NSString *)operatorString:(enum QueryParameterOperator)operator {
    NSString *string = nil;
    switch (operator) {
        case QueryParameterOperatorEquals:
            string = @"=";
            break;
        case QueryParameterOperatorGreaterOrEquals:
            string = @">=";
            break;
        case QueryParameterOperatorGreaterThan:
            string = @">";
            break;
        case QueryParameterOperatorLessOrEquals:
            string = @"<=";
            break;
        case QueryParameterOperatorLessThan:
            string = @"<";
            break;
    }
    return string;
}

@end
