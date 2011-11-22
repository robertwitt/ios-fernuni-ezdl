//
//  NSString+NSStringExtension.m
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+NSStringExtension.h"

@implementation NSString (NSStringExtension)

- (BOOL)isNilOrEmpty
{
    return (!self || [self isEqualToString:@""]);
}

@end
