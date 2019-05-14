//
//  QueryResultContent.h
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResult.h"
#import "QueryResultGrouping.h"
#import "QueryResultRow.h"
#import "QueryResultSorting.h"

/*!
 @class QueryResultContent
 @abstract Interface to content of a QueryResult object
 @discussion The main client of this class is the QueryResultViewController. It is an auxiliary class to manage the query result content, especially to group by, sort by, and filter by attributes of a query result entry. The class offers an easy-to-use interface designed for Query Result View Controller's table view to manage the query result content.
 */
@interface QueryResultContent : NSObject

/*!
 @property sorting
 @abstract How the query result content is sorted currently.
 */
@property (nonatomic, strong) QueryResultSorting *sorting;

/*!
 @property grouping
 @abstract How the query result content is grouped currently.
 */

@property (nonatomic, strong) QueryResultGrouping *grouping;

/*!
 @property filterString
 @abstract How the query result content is filtered currently.
 */
@property (nonatomic, strong) NSString *filterString;

/*!
 @property sections
 @abstract Array of all the sections to display in Query Result View Controller's table view.
 */
@property (nonatomic, strong, readonly) NSArray *sections;

/*!
 @property allDocuments
 @abstract Array with all the documents in the query result.
 */
@property (nonatomic, strong, readonly) NSArray *allDocuments;

/*!
 @property numberOfResults
 @abstract Number of results in this content object.
 */
@property (nonatomic, readonly) NSInteger numberOfResults;

/*!
 @method queryResultContentWithQueryResult:
 @abstract Creates a new QueryResultContent object with a specific query result.
 @param queryResult A query result object
 @result The new Query Result Content object
 */
+ (QueryResultContent *)queryResultContentWithQueryResult:(QueryResult *)queryResult;

/*!
 @method initWithQueryResult:
 @abstract Initializes a new QueryResultContent object with a specific query result.
 @param queryResult A query result object
 @result The new Query Result Content object
 */
- (id)initWithQueryResult:(QueryResult *)queryResult;

/*!
 @method sectionAtIndex:
 @abstract Returns the title of the section at a specified index.
 @param index Section index
 @result Section title 
 */
- (NSString *)sectionAtIndex:(NSInteger)index;

/*!
 @method rowsInSection:
 @abstract Returns all the Query Result Rows in a specified section.
 @param section Section
 @result Array of QueryResultRows objects
 */
- (NSArray *)rowsInSection:(NSString *)section;

/*!
 @method rowsInSectionAtIndex:
 @abstract Returns all the Query Result Rows in section at a specified index.
 @param index Section index
 @result Array of QueryResultRows objects
 */
- (NSArray *)rowsInSectionAtIndex:(NSInteger)index;

/*!
 @method rowsInSectionAtIndex:
 @abstract Returns the Query Result Row at a specified index path.
 @param indexPath Index path
 @result A Query Result Row
 */
- (QueryResultRow *)rowAtIndexPath:(NSIndexPath *)indexPath;

@end
