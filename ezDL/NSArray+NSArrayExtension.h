//
//  NSArray+NSArrayExtension.h
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @category NSArrayExtension
 @abstract Enhancement of NSArray
 @discussion This category adds additional useful methods the iOS SDK doesn't provide.
 */
@interface NSArray (NSArrayExtension)

/*!
 @property notEmpty
 @abstract Indicates whether or not an array instance contains elements.
 */
@property (nonatomic, readonly, getter=isNotEmpty) BOOL notEmpty;

@end
