//
//  BasicQueryParser.h
//  ezDL
//
//  Created by Robert Witt on 27.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryParser.h"

/*!
 @class BasicQueryParser
 @abstract Query parser to build a query expression from a query string
 @discussion This parser is supposed to be used to parse the user input in an basic query view. It builds a query expression by query string.
 */
@interface BasicQueryParser : QueryParser

/*!
 @property queryString
 @abstract The query string to be parsed
 */
@property (nonatomic, strong) NSString *queryString;

/*!
 @method parserWithString:
 @abstract Convenience method to create a BasicQueryParser instance
 @param queryString The query string to be parsed
 @return The created BasicQueryParser object
 */
+ (BasicQueryParser *)parserWithString:(NSString *)string;

/*!
 @method initWithString:
 @abstract Initializes a BasicQueryParser instance
 @param queryString The query string to be parsed
 @return The created BasicQueryParser object
 */
- (id)initWithString:(NSString *)string;

@end
