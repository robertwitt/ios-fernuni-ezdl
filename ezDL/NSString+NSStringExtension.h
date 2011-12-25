//
//  NSString+NSStringExtension.h
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface NSString (NSStringExtension)

@property (nonatomic, readonly, getter=isNotEmpty) BOOL notEmpty;

- (BOOL)containsString:(NSString *)string;
- (NSString *)trimmedString;
- (BOOL)isWord;
- (BOOL)isQuote;

@end
