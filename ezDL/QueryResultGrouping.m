//
//  QueryResultGrouping.m
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultGrouping.h"

@implementation QueryResultGrouping

@synthesize groupingType = _groupingType;

+ (QueryResultGrouping *)authorsGrouping
{
    return [QueryResultGrouping queryResultGroupingWithGroupingType:QueryResultGroupingTypeAuthors];
}

+ (QueryResultGrouping *)decadeGrouping
{
    return [QueryResultGrouping queryResultGroupingWithGroupingType:QueryResultGroupingTypeDecade];
}

+ (QueryResultGrouping *)libraryGrouping
{
    return [QueryResultGrouping queryResultGroupingWithGroupingType:QueryResultGroupingTypeLibrary];
}

+ (QueryResultGrouping *)nothingGrouping
{
    return [QueryResultGrouping queryResultGroupingWithGroupingType:QueryResultGroupingTypeNothing];
}

+ (QueryResultGrouping *)queryResultGroupingWithGroupingType:(enum QueryResultGroupingType)groupingType
{
    return [[QueryResultGrouping alloc] initWithGroupingType:groupingType];
}

- (id)initWithGroupingType:(enum QueryResultGroupingType)groupingType
{
    self = [self init];
    if (self) _groupingType = groupingType;
    return self;
}

- (NSString *)localizedShortText
{
    NSString *shortText = nil;
    switch (self.groupingType)
    {
        case QueryResultGroupingTypeAuthors:
            shortText = NSLocalizedString(@"Authors", nil);
            break;
        case QueryResultGroupingTypeDecade:
            shortText = NSLocalizedString(@"Decade", nil);
            break;
        case QueryResultGroupingTypeLibrary:
            shortText = NSLocalizedString(@"Library", nil);
            break;
        case QueryResultGroupingTypeNothing:
            shortText = NSLocalizedString(@"Nothing", nil);
            break;
    }
    return shortText;
}

- (BOOL)isEqual:(id)object
{
    BOOL isEqual = NO;
    QueryResultGrouping *other = object;
    if (self.groupingType == other.groupingType) isEqual = YES;
    return isEqual;
}

@end
