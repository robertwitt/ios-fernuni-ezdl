//
//  QueryResult.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Query.h"

/*!
 @class QueryResult
 @abstract Result after execution of a query
 @discussion This class encapsulates data to build a query result in the ezDL application. It collects an array with QueryResultItems where the data is in.
 */
@interface QueryResult : NSObject

/*!
 @property query
 @abstract The Query object that built this query result
 */
@property (nonatomic, strong, readonly) Query *query;

/*!
 @property items
 @abstract An array with the QueryResultItems
 */
@property (nonatomic, strong, readonly) NSArray *items;

/*!
 @method queryResultWithQuery:items:
 @abstract Convenience method to build a new QueryResult object
 @param query Query that build this result
 @param items An array with the QueryResultItems
 @return The created QueryResult object
 */
+ (QueryResult *)queryResultWithQuery:(Query *)query items:(NSArray *)items;

/*!
 @method initWithQuery:items:
 @abstract Initializes a new QueryResult object
 @param query Query that build this result
 @param items An array with the QueryResultItems
 @return The created QueryResult object
 */
- (id)initWithQuery:(Query *)query items:(NSArray *)items;

@end
