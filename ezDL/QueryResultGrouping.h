//
//  QueryResultGrouping.h
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultOption.h"

enum QueryResultGroupingType {
    QueryResultGroupingTypeAuthors,
    QueryResultGroupingTypeDecade,
    QueryResultGroupingTypeLibrary,
    QueryResultGroupingTypeNothing
};

/*!
 @class QueryResultGrouping
 @abstract Option in the Query Result Grouping View Controller a query result can by grouped by.
 @discussion The basis to differ the grouping attributes is enumeration type QueryResultGroupingType.
 */
@interface QueryResultGrouping : NSObject <QueryResultOption>

/*!
 @property groupingType
 @abstract Type in this grouping option (authors, decade, library, or not grouped)
 */
@property (nonatomic, readonly) enum QueryResultGroupingType groupingType;

/*!
 @property localizedShortText
 @abstract Localized description
 */
@property (nonatomic, strong, readonly) NSString *localizedShortText;

/*!
 @method authorsGrouping
 @abstract Convenience method to create an object with grouping type QueryResultGroupingTypeAuthors
 @result The new grouping option
 */
+ (QueryResultGrouping *)authorsGrouping;

/*!
 @method decadeGrouping
 @abstract Convenience method to create an object with grouping type QueryResultGroupingTypeDecade
 @result The new grouping option
 */
+ (QueryResultGrouping *)decadeGrouping;

/*!
 @method libraryGrouping
 @abstract Convenience method to create an object with grouping type QueryResultGroupingTypeLibrary
 @result The new grouping option
 */
+ (QueryResultGrouping *)libraryGrouping;

/*!
 @method nothingGrouping
 @abstract Convenience method to create an object with grouping type QueryResultGroupingTypeNothing
 @result The new grouping option
 */
+ (QueryResultGrouping *)nothingGrouping;

/*!
 @method queryResultGroupingWithGroupingType:
 @abstract Convenience method to create an object with a given grouping type
 @param groupingType a QueryResultGroupingType value
 @result The new grouping option
 */
+ (QueryResultGrouping *)queryResultGroupingWithGroupingType:(enum QueryResultGroupingType)groupingType;

/*!
 @method initWithGroupingType:
 @abstract Initializes an object with a given grouping type
 @param groupingType a QueryResultGroupingType value
 @result The new grouping option
 */
- (id)initWithGroupingType:(enum QueryResultGroupingType)groupingType;

@end
