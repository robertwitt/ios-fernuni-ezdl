//
//  QueryResultOption.h
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @protocol QueryResultOption
 @abstract Option in the Query Result View Controller to edit the query result list.
 @discussion This protocol defines all methods needed to build a general option.
 */
@protocol QueryResultOption <NSObject>

/*!
 @method localizedShortText
 @abstract Returns a localized string that describes this option.
 @return Localized description
 */
- (NSString *)localizedShortText;

@end
