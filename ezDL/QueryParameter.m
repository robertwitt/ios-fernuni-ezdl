//
//  QueryParameter.m
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryParameter.h"
#import "QueryGlobals.h"


@implementation QueryParameter

@synthesize key = _key;
@synthesize value = _value;
@synthesize operator = _operator;

+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value
{
    return [[QueryParameter alloc] initWithKey:key value:value];
}

+ (QueryParameter *)parameterWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator
{
    return [[QueryParameter alloc] initWithKey:key value:value operator:operator];
}

- (id)initWithKey:(NSString *)key value:(NSString *)value
{
    return [[QueryParameter alloc] initWithKey:key value:value operator:QueryParameterOperatorGreaterOrEquals];
}

- (id)initWithKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator
{
    self = [self init];
    if (self)
    {
        self.key = key;
        self.value = value;
        self.operator = operator;
    }
    return self;
}

- (NSString *)queryString
{
    NSString *string = nil;
    
    if (self.key.notEmpty && ![self.key isEqualToString:kQueryParameterKeyText])
    {
        if (self.operator == QueryParameterOperatorNotEquals)
        {
            string = [NSString stringWithFormat:@"%@ %@%@%@", [QueryParameter operatorString:QueryParameterOperatorNotEquals], self.key, [QueryParameter operatorString:QueryParameterOperatorEquals], self.value];
        }
        else
        {
            string = [NSString stringWithFormat:@"%@%@%@", self.key, [QueryParameter operatorString:self.operator], self.value];
        }
    }
    else
    {
        if (self.operator == QueryParameterOperatorNotEquals)
        {
            string = [NSString stringWithFormat:@"%@ @", [QueryParameter operatorString:QueryParameterOperatorNotEquals], self.value];
        }
        else if (self.operator == QueryParameterOperatorEquals)
        {
            string = self.value;
        }
        else
        {
            string = [NSString stringWithFormat:@"%@%@", [QueryParameter operatorString:self.operator], self.value];
        }
    }
    
    return string;
}

+ (enum QueryParameterOperator)operatorFromString:(NSString *)string
{
    if ([string isEqualToString:@"="]) return QueryParameterOperatorEquals;
    else if ([string isEqualToString:@">="]) return QueryParameterOperatorGreaterOrEquals;
    else if ([string isEqualToString:@">"]) return QueryParameterOperatorGreaterThan;
    else if ([string isEqualToString:@"<="]) return QueryParameterOperatorLessOrEquals;
    else if ([string isEqualToString:@"<"]) return QueryParameterOperatorLessThan;
    else if ([string isEqualToString:@"NOT"]) return QueryParameterOperatorNotEquals;
    
    // If we got this far, string doesn't represent a valid operator. Throw excpetion.
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"%@ isn't a valid query parameter operator", string]
                                 userInfo:nil];
}

+ (NSString *)operatorString:(enum QueryParameterOperator)operator
{
    NSString *string = nil;
    switch (operator) 
    {
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
        case QueryParameterOperatorNotEquals:
            string = @"NOT";
            break;
    }
    return string;
}

@end
