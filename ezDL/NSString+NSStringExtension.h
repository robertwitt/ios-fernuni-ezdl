//
//  NSString+NSStringExtension.h
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @category NSStringExtension
 @abstract Enhancement of NSString
 @discussion This category adds additional useful methods the iOS SDK doesn't provide.
 */
@interface NSString (NSStringExtension)

/*!
 @property notEmpty
 @abstract Indicates whether or not a string instance contains characters.
 */
@property (nonatomic, readonly, getter=isNotEmpty) BOOL notEmpty;

/*!
 @method trimmedString
 @abstract Returns a version of the receiver where potential whitespaces at beginning and end have been truncated.
 @return Trimmed string
 */
- (NSString *)trimmedString;

@end
