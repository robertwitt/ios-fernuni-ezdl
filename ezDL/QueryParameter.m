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
@synthesize isNot = _isNot;

- (NSString *)queryString
{
    NSString *string = @"";
    if (self.isNot) string = [kQueryOperatorNot stringByAppendingString:@" "];
    
    if (self.key.notEmpty && ![self.key isEqualToString:kQueryParameterKeyText])
    {
        string = [string stringByAppendingFormat:@"%@=%@", self.key, self.value];
    }
    else
    {
        string = [string stringByAppendingString:self.value];
    }
    
    return string;
}

@end
