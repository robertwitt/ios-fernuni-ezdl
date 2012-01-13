//
//  QueryResultRow.h
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultItem.h"
#import "QueryResultGrouping.h"
#import "QueryResultSorting.h"

/*!
 @class QueryResultRow
 @abstract Flat copy of a QueryResultItem.
 @discussion This class is the line type of the Query Result Content class. It is mainly a copy of a QueryResultItem object, an entry in the Query Result. The main purpose is to ease grouping, sorting, and filtering a Query Result in the Query Result View Controller.
 */
@interface QueryResultRow : NSObject

/*!
 @property document
 @abstract Document object
 */
@property (nonatomic, strong, readonly) Document *document;

/*!
 @property documentTitle
 @abstract Title of the Document object
 */
@property (nonatomic, strong, readonly) NSString *documentTitle;

/*!
 @property documentAuthors
 @abstract All authors of the Document object concatenated as string
 */
@property (nonatomic, strong, readonly) NSString *documentAuthors;

/*!
 @property documentYear
 @abstract Year of the Document object
 */
@property (nonatomic, strong, readonly) NSString *documentYear;

/*!
 @property decade
 @abstract Decade (as string) of the Document's year
 */
@property (nonatomic, strong, readonly) NSString *decade;

/*!
 @property libraryName
 @abstract Name of the library the Document was found in
 */
@property (nonatomic, strong, readonly) NSString *libraryName;

/*!
 @property relevance
 @abstract Relevance of the found document
 */
@property (nonatomic, readonly) float relevance;

/*!
 @method queryResultRowWithItem:
 @abstract Convenience method to create a new QueryResultRow instance by a QueryResultItem
 @param item a Query Result Item
 @result The created QueryResultRow instance
 */
+ (QueryResultRow *)queryResultRowWithItem:(QueryResultItem *)item;

/*!
 @method initWithItem:
 @abstract Initializes a new QueryResultRow instance with a QueryResultItem
 @param item a Query Result Item
 @result The created QueryResultRow instance
 */
- (id)initWithItem:(QueryResultItem *)item;

/*!
 @method keyOfSortingCriterion:
 @abstract Returns the property key of this class that matches the specified sorting criterion.
 @param sortingCriterion A QueryResultSortingCriterion object
 @result Property key
 */
+ (NSString *)keyOfSortingCriterion:(QueryResultSortingCriterion *)sortingCriterion;

/*!
 @method keyOfGrouping:
 @abstract Returns the property key of this class that matches the specified grouping.
 @param grouping A QueryResultGrouping object
 @return Property key
 */
+ (NSString *)keyOfGrouping:(QueryResultGrouping *)grouping;

@end
