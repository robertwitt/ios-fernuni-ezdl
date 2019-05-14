//
//  QueryPart.h
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @protocol QueryPart
 @abstract Part of a query
 @discussion This protocol defines a generic interface for parts of a query.
 */
@protocol QueryPart <NSObject>

/*!
 @method queryString
 @abstract Returns a string representation of this QueryPart
 @return A query string
 */
- (NSString *)queryString;

@end
