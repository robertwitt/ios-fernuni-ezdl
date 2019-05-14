//
//  QueryService.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryChoice.h"
#import "QueryParameter.h"
#import "QueryResult.h"

/*!
 @protocol QueryService
 @abstract Service interface for managing queries
 @discussion This protocols defines and collects methods to build, manage and execute queries. Clients must use the ServiceFactory class to get an instance.
 */
@protocol QueryService <NSObject>

/*!
 @method currentLibraryChoice
 @abstract Returns the digital libraries the has chosen to search in encapsulated in a LibraryChoice object.
 @return User's chosen digital libraries
 */
- (LibraryChoice *)currentLibraryChoice;

/*!
 @method checkQuerySyntaxFromString:
 @abstract Returns true if the specified query string is syntactically correct, otherwise false.
 @param string A query string
 @return Result of the query check
 */
- (BOOL)checkQuerySyntaxFromString:(NSString *)string;

/*!
 @method buildQueryFromString
 @abstract Builds a Query object from a string
 @param string A query string
 @return The built Query object
 */
- (Query *)buildQueryFromString:(NSString *)string;

/*!
 @method buildQueryFromParameters:
 @abstract Builds a Query object from a parameter dictionary.
 @param parameters Dictionary with query string as value and the key is a constant string from QueryParameter.h
 @return The built Query object
 */
- (Query *)buildQueryFromParameters:(NSDictionary *)parameters;

/*!
 @method executeQuery:withError:
 @abstract Calls the ezDL backend and executes a query to get a QueryResult object
 @param query A Query object
 @param error Execution error
 @return QueryResult object returned by ezDL
 */
- (QueryResult *)executeQuery:(Query *)query withError:(NSError **)error;

@end
