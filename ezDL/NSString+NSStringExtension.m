//
//  NSString+NSStringExtension.m
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+NSStringExtension.h"

@implementation NSString (NSStringExtension)

- (BOOL)isNotEmpty {
    return (![self isEqualToString:@""]);
}

- (NSString *)trimmedString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
