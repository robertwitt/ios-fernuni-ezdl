//
//  NSString+NSStringExtension.m
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+NSStringExtension.h"

@implementation NSString (NSStringExtension)

- (BOOL)isNotEmpty
{
    return (![self isEqualToString:@""]);
}

- (BOOL)containsString:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    BOOL contains = YES;
    
    if (range.location == NSNotFound && range.length == 0) contains = NO;
    return contains;
}

- (NSString *)trimmedString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isWord
{
    NSCharacterSet *characterSet = [NSCharacterSet alphanumericCharacterSet];
    for (int i = 0; i < self.length; i++)
    {
        unichar character = [self characterAtIndex:i];
        if (![characterSet characterIsMember:character]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isQuote
{
    // First check if first and last character are equal to the quote sign (")
    if ([self characterAtIndex:0] != '"') return NO;
    if ([self characterAtIndex:(self.length - 1)] != '"') return NO;
    
    // Now get the quote's content and check if there are any other quote signs in it
    NSRange range = NSMakeRange(1, self.length - 2);
    NSString *quoteContent = [self substringWithRange:range];
    return ![quoteContent containsString:@"\""];
}

@end
