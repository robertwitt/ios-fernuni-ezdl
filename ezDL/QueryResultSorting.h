//
//  QueryResultSorting.h
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultOption.h"


enum QueryResultSortingCriterionType {
    QueryResultSortingCriterionTypeAuthor,
    QueryResultSortingCriterionTypeRelevance,
    QueryResultSortingCriterionTypeTitle,
    QueryResultSortingCriterionTypeYear
};

/*!
 @class QueryResultSortingCriterion
 @abstract Criterion in the QueryResultSortingViewController a query result can be sorted by.
 @discussion This class encapsulates the state of a criterion by using enumeration QueryResultSortingCriterionType.
 */
@interface QueryResultSortingCriterion : NSObject

/*!
 @property criterionType
 @abstract Type of the criterion (author, relevance, title, or year)
 */
@property (nonatomic, readonly) enum QueryResultSortingCriterionType criterionType;

/*!
 @property localizedShortText
 @abstract Localized description
 */
@property (nonatomic, strong, readonly) NSString *localizedShortText;

/*!
 @method authorSortingCriterion
 @abstract Convenience method to create an object with criterion type QueryResultSortingCriterionTypeAuthor
 @result The new sorting criterion
 */
+ (QueryResultSortingCriterion *)authorSortingCriterion;

/*!
 @method relevanceSortingCriterion
 @abstract Convenience method to create an object with criterion type QueryResultSortingCriterionTypeRelevance
 @result The new sorting criterion
 */
+ (QueryResultSortingCriterion *)relevanceSortingCriterion;

/*!
 @method titleSortingCriterion
 @abstract Convenience method to create an object with criterion type QueryResultSortingCriterionTypeTitle
 @result The new sorting criterion
 */
+ (QueryResultSortingCriterion *)titleSortingCriterion;

/*!
 @method yearSortingCriterion
 @abstract Convenience method to create an object with criterion type QueryResultSortingCriterionTypeYear
 @result The new sorting criterion
 */
+ (QueryResultSortingCriterion *)yearSortingCriterion;

/*!
 @method queryResultSortingCriterionWithCriterionType:
 @abstract Convenience method to create an object with a given criterion type
 @param criterionType a QueryResultSortingCriterionType value
 @result The new sorting criterion
 */
+ (QueryResultSortingCriterion *)queryResultSortingCriterionWithCriterionType:(enum QueryResultSortingCriterionType)criterionType;

/*!
 @method initWithCriterionType:
 @abstract Initializes an object with a given criterion type
 @param criterionType a QueryResultSortingCriterionType value
 @result The new sorting criterion
 */
- (id)initWithCriterionType:(enum QueryResultSortingCriterionType)criterionType;

@end


enum QueryResultSortingDirectionType{
    QueryResultSortingDirectionTypeAscending,
    QueryResultSortingDirectionTypeDescending
};

/*!
 @class QueryResultSortingDirection
 @abstract Direction in the QueryResultSortingViewController (ascending/descending) a query result can be sorted by.
 @discussion This class encapsulates the state of a direction by using enumeration QueryResultSortingDirectionType.
 */
@interface QueryResultSortingDirection : NSObject

/*!
 @property directionType
 @abstract The direction (ascending or descending)
 */
@property (nonatomic, readonly) enum QueryResultSortingDirectionType directionType;

/*!
 @property localizedShortText
 @abstract Localized description
 */
@property (nonatomic, strong, readonly) NSString *localizedShortText;

/*!
 @method ascendingSortingDirection
 @abstract Convenience method to create an object with direction type QueryResultSortingDirectionTypeAscending
 @result The new sorting direction
 */
+ (QueryResultSortingDirection *)ascendingSortingDirection;

/*!
 @method descendingSortingDirection
 @abstract Convenience method to create an object with direction type QueryResultSortingDirectionTypeDescending
 @result The new sorting direction
 */
+ (QueryResultSortingDirection *)descendingSortingDirection;

/*!
 @method queryResultSortingDirectionWithDirectionType:
 @abstract Convenience method to create an object with a given direction type
 @param directionType a QueryResultSortingDirectionType value
 @result The new sorting direction
 */
+ (QueryResultSortingDirection *)queryResultSortingDirectionWithDirectionType:(enum QueryResultSortingDirectionType)directionType;

/*!
 @method initWithDirectionType:
 @abstract Initializes an object with a given direction type
 @param directionType a QueryResultSortingDirectionType value
 @result The new sorting direction
 */
- (id)initWithDirectionType:(enum QueryResultSortingDirectionType)directionType;

@end


/*!
 @class QueryResultSorting
 @abstract Option in the Query Result Sorting View Controller a query result can by sorted by.
 @discussion It combines both the QueryResultSortingCriterion and QueryResultSortingDirection to build the sorting option.
 */
@interface QueryResultSorting : NSObject <QueryResultOption>

/*!
 @property criterion
 @abstract Criterion in this sorting option
 */
@property (nonatomic, strong, readonly) QueryResultSortingCriterion *criterion;

/*!
 @property direction
 @abstract Direction in this sorting option
 */
@property (nonatomic, strong, readonly) QueryResultSortingDirection *direction;

/*!
 @property localizedShortText
 @abstract Localized description
 */
@property (nonatomic, strong, readonly) NSString *localizedShortText;

/*!
 @method queryResultSortingWithCriterion:direction:
 @abstract Convenience method to create a new sorting option with given criterion and direction.
 @param criterion A QueryResultSortingCriterion instance
 @param direction A QueryResultSortingDirection instance
 @result The new sorting option
 */
+ (QueryResultSorting *)queryResultSortingWithCriterion:(QueryResultSortingCriterion *)criterion direction:(QueryResultSortingDirection *)direction;

/*!
 @method queryResultSortingWithCriterionType:directionType:
 @abstract Convenience method to create a new sorting option with given criterion type and direction type.
 @param criterion A QueryResultSortingCriterionType enumeration value
 @param direction A QueryResultSortingDirectionType enumeration value
 @result The new sorting option
 */
+ (QueryResultSorting *)queryResultSortingWithCriterionType:(enum QueryResultSortingCriterionType)criterionType directionType:(enum QueryResultSortingDirectionType)directionType;

/*!
 @method initWithCriterion:direction:
 @abstract Initializes a new sorting option with given criterion and direction.
 @param criterion A QueryResultSortingCriterion instance
 @param direction A QueryResultSortingDirection instance
 @result The new sorting option
 */
- (id)initWithCriterion:(QueryResultSortingCriterion *)criterion direction:(QueryResultSortingDirection *)direction;

/*!
 @method initWithCriterionType:directionType:
 @abstract Initializes a new sorting option with given criterion type and direction type.
 @param criterion A QueryResultSortingCriterionType enumeration value
 @param direction A QueryResultSortingDirectionType enumeration value
 @result The new sorting option
 */
- (id)initWithCriterionType:(enum QueryResultSortingCriterionType)criterionType directionType:(enum QueryResultSortingDirectionType)directionType;

@end
