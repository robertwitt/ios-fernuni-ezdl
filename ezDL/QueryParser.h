//
//  QueryParser.h
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExpression.h"

/*!
 @class QueryParser
 @abstract Abstract parser to build a Query Expression
 @discussion This class defines an abstract interface to build a query expression that can be used to build a baseExpression for a Query object.
 */
@interface QueryParser : NSObject

/*!
 @method parsedExpressionWithError:
 @abstract Creates a QueryExpression or sets the error parameter if the parser weren't able to parse
 @param error Parsing error
 @return The parsed QueryExpression instance
 */
- (id<QueryExpression>)parsedExpressionWithError:(NSError **)error;

@end
