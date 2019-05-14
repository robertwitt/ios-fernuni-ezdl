//
//  QuerySyntaxChecker.h
//  ezDL
//
//  Created by Robert Witt on 27.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @class QuerySyntaxChecker
 @abstract Checking of a query's syntax
 @discussion This class is able to check if a query string is syntactically correct.
 */
@interface QuerySyntaxChecker : NSObject

/*!
 @method checkString:
 @abstract Returns true if the specified query string is syntactically correct, otherwise false.
 @param string A query string
 @return Result of the query check
 */
- (BOOL)checkString:(NSString *)string;

@end
