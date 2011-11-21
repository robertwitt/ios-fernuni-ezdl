//
//  QueryResultSorting.m
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultSorting.h"


@implementation QueryResultSortingCriterion

@synthesize criterionType = _criterionType;

+ (QueryResultSortingCriterion *)authorSortingCriterion
{
    return [QueryResultSortingCriterion queryResultSortingCriterionWithCriterionType:QueryResultSortingCriterionTypeAuthor];
}

+ (QueryResultSortingCriterion *)relevanceSortingCriterion
{
    return [QueryResultSortingCriterion queryResultSortingCriterionWithCriterionType:QueryResultSortingCriterionTypeRelevance];
}

+ (QueryResultSortingCriterion *)titleSortingCriterion
{
    return [QueryResultSortingCriterion queryResultSortingCriterionWithCriterionType:QueryResultSortingCriterionTypeTitle];
}

+ (QueryResultSortingCriterion *)yearSortingCriterion
{
    return [QueryResultSortingCriterion queryResultSortingCriterionWithCriterionType:QueryResultSortingCriterionTypeYear];
}

+ (QueryResultSortingCriterion *)queryResultSortingCriterionWithCriterionType:(enum QueryResultSortingCriterionType)criterionType
{
    return [[QueryResultSortingCriterion alloc] initWithCriterionType:criterionType];
}

- (id)initWithCriterionType:(enum QueryResultSortingCriterionType)criterionType
{
    self = [self init];
    if (self) _criterionType = criterionType;
    return self;
}

- (NSString *)localizedShortText
{
    NSString *shortText = nil;    
    switch (self.criterionType)
    {
        case QueryResultSortingCriterionTypeAuthor:
            shortText = NSLocalizedString(@"Author", nil);
            break;
        case QueryResultSortingCriterionTypeRelevance:
            shortText = NSLocalizedString(@"Relevance", nil);
            break;
        case QueryResultSortingCriterionTypeTitle:
            shortText = NSLocalizedString(@"Title", nil);
            break;
        case QueryResultSortingCriterionTypeYear:
            shortText = NSLocalizedString(@"Year", nil);
            break;
    }
    return shortText;
}

- (BOOL)isEqual:(id)object
{
    BOOL isEqual = NO;
    QueryResultSortingCriterion *other = object;
    if (self.criterionType == other.criterionType) isEqual = YES;
    return isEqual;
}

@end


@implementation QueryResultSortingDirection

@synthesize directionType = _directionType;

+ (QueryResultSortingDirection *)ascendingSortingDirection
{
    return [QueryResultSortingDirection queryResultSortingDirectionWithDirectionType:QueryResultSortingDirectionTypeAscending];
}

+ (QueryResultSortingDirection *)descendingSortingDirection
{
    return [QueryResultSortingDirection queryResultSortingDirectionWithDirectionType:QueryResultSortingDirectionTypeDescending];
}

+ (QueryResultSortingDirection *)queryResultSortingDirectionWithDirectionType:(enum QueryResultSortingDirectionType)directionType
{
    return [[QueryResultSortingDirection alloc] initWithDirectionType:directionType];
}

- (id)initWithDirectionType:(enum QueryResultSortingDirectionType)directionType
{
    self = [self init];
    if (self) _directionType = directionType;
    return self;
}

- (NSString *)localizedShortText
{
    NSString *shortText = nil;
    switch (self.directionType)
    {
        case QueryResultSortingDirectionTypeAscending:
            shortText = NSLocalizedString(@"ascending", nil);
            break;
        case QueryResultSortingDirectionTypeDescending:
            shortText = NSLocalizedString(@"descending", nil);
            break;
    }
    return shortText;
}

- (BOOL)isEqual:(id)object
{
    BOOL isEqual = NO;
    QueryResultSortingDirection *other = object;
    if (self.directionType == other.directionType) isEqual = YES;
    return isEqual;
}

@end


@implementation QueryResultSorting

@synthesize criterion = _criterion;
@synthesize direction = _direction;

+ (QueryResultSorting *)queryResultSortingWithCriterion:(QueryResultSortingCriterion *)criterion direction:(QueryResultSortingDirection *)direction
{
    return [[QueryResultSorting alloc] initWithCriterion:criterion direction:direction];
}

+ (QueryResultSorting *)queryResultSortingWithCriterionType:(enum QueryResultSortingCriterionType)criterionType directionType:(enum QueryResultSortingDirectionType)directionType
{
    return [[QueryResultSorting alloc] initWithCriterionType:criterionType directionType:directionType];
}

- (id)initWithCriterion:(QueryResultSortingCriterion *)criterion direction:(QueryResultSortingDirection *)direction
{
    self = [self init];
    if (self)
    {
        _criterion = criterion;
        _direction = direction;
    }
    return self;
}

- (id)initWithCriterionType:(enum QueryResultSortingCriterionType)criterionType directionType:(enum QueryResultSortingDirectionType)directionType
{
    QueryResultSorting *sorting = [[QueryResultSorting alloc] initWithCriterion:[QueryResultSortingCriterion queryResultSortingCriterionWithCriterionType:criterionType]
                                                                      direction:[QueryResultSortingDirection queryResultSortingDirectionWithDirectionType:directionType]];
    return sorting;
}

- (NSString *)localizedShortText
{
    return [NSString stringWithFormat:@"%@, %@", self.criterion.localizedShortText, self.direction.localizedShortText];
}

- (BOOL)isEqual:(id)object
{
    BOOL isEqual = NO;
    QueryResultSorting *other = object;
    
    if ([self.criterion isEqual:other.criterion] && [self.direction isEqual:other.direction])
    {
        isEqual = YES;
    }
    return isEqual;
}

@end
