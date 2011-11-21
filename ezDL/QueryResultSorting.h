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

@interface QueryResultSortingCriterion : NSObject

@property (nonatomic, readonly) enum QueryResultSortingCriterionType criterionType;
@property (nonatomic, strong, readonly) NSString *localizedShortText;

+ (QueryResultSortingCriterion *)authorSortingCriterion;
+ (QueryResultSortingCriterion *)relevanceSortingCriterion;
+ (QueryResultSortingCriterion *)titleSortingCriterion;
+ (QueryResultSortingCriterion *)yearSortingCriterion;
+ (QueryResultSortingCriterion *)queryResultSortingCriterionWithCriterionType:(enum QueryResultSortingCriterionType)criterionType;
- (id)initWithCriterionType:(enum QueryResultSortingCriterionType)criterionType;

@end


enum QueryResultSortingDirectionType{
    QueryResultSortingDirectionTypeAscending,
    QueryResultSortingDirectionTypeDescending
};

@interface QueryResultSortingDirection : NSObject

@property (nonatomic, readonly) enum QueryResultSortingDirectionType directionType;
@property (nonatomic, strong, readonly) NSString *localizedShortText;

+ (QueryResultSortingDirection *)ascendingSortingDirection;
+ (QueryResultSortingDirection *)descendingSortingDirection;
+ (QueryResultSortingDirection *)queryResultSortingDirectionWithDirectionType:(enum QueryResultSortingDirectionType)directionType;
- (id)initWithDirectionType:(enum QueryResultSortingDirectionType)directionType;

@end


@interface QueryResultSorting : NSObject <QueryResultOption>

@property (nonatomic, strong, readonly) QueryResultSortingCriterion *criterion;
@property (nonatomic, strong, readonly) QueryResultSortingDirection *direction;
@property (nonatomic, strong, readonly) NSString *localizedShortText;

+ (QueryResultSorting *)queryResultSortingWithCriterion:(QueryResultSortingCriterion *)criterion direction:(QueryResultSortingDirection *)direction;
+ (QueryResultSorting *)queryResultSortingWithCriterionType:(enum QueryResultSortingCriterionType)criterionType directionType:(enum QueryResultSortingDirectionType)directionType;
- (id)initWithCriterion:(QueryResultSortingCriterion *)criterion direction:(QueryResultSortingDirection *)direction;
- (id)initWithCriterionType:(enum QueryResultSortingCriterionType)criterionType directionType:(enum QueryResultSortingDirectionType)directionType;

@end
