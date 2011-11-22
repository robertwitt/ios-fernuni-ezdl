//
//  QueryResultRow.m
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultRow.h"
#import "Author.h"


@interface QueryResultRow ()

- (NSString *)stringFromAuthors:(NSArray *)authors;
- (NSString *)decadeFromYear:(NSString *)year;

@end


@implementation QueryResultRow

@synthesize document = _document;
@synthesize documentTitle = _documentTitle;
@synthesize documentAuthors = _documentAuthors;
@synthesize documentYear = _documentYear;
@synthesize decade = _decade;
@synthesize libraryName = _libraryName;
@synthesize relevance = _relevance;

+ (QueryResultRow *)queryResultRowWithItem:(QueryResultItem *)item
{
    return [[QueryResultRow alloc] initWithItem:item];
}

- (id)initWithItem:(QueryResultItem *)item
{
    self = [self init];
    if (self)
    {
        _document = item.document;
        _documentTitle = item.document.title;
        _documentAuthors = [self stringFromAuthors:item.document.authors];
        _documentYear = item.document.year;
        _decade = [self decadeFromYear:item.document.year];
        _libraryName = item.library.name;
        _relevance = item.relevance;
    }
    return self;
}

- (NSString *)stringFromAuthors:(NSArray *)authors
{
    NSMutableString __block *string = nil;
    
    [authors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Author *author = (Author *)obj;
        if (idx == 0) 
        {
            string = [NSMutableString stringWithString:author.fullName];
        } else 
        {
            [string appendFormat:@"; %@", author.fullName];
        }
    }];
    
    return string;
}

- (NSString *)decadeFromYear:(NSString *)year
{
    NSString *decade = nil;
    if (year.length == 4) 
    {
        NSString *substring = [year substringToIndex:3];
        decade = [NSString stringWithFormat:@"%@ %@0 - %@9", NSLocalizedString(@"Years", nil), substring, substring];
    }
    return decade;
}

+ (NSString *)keyOfSortingCriterion:(QueryResultSortingCriterion *)sortingCriterion
{
    NSString *key = nil;
    switch (sortingCriterion.criterionType)
    {
        case QueryResultSortingCriterionTypeAuthor:
            key = @"documentAuthors";
            break;
        case QueryResultSortingCriterionTypeRelevance:
            key = @"relevance";
            break;
        case QueryResultSortingCriterionTypeTitle:
            key = @"documentTitle";
            break;
        case QueryResultSortingCriterionTypeYear:
            key = @"documentYear";
            break;
    }
    return key;
}

+ (NSString *)keyOfGrouping:(QueryResultGrouping *)grouping
{
    NSString *key = nil;
    switch (grouping.groupingType) {
        case QueryResultGroupingTypeAuthors:
            key = @"documentAuthors";
            break;
        case QueryResultGroupingTypeDecade:
            key = @"decade";
            break;
        case QueryResultGroupingTypeLibrary:
            key = @"libraryName";
            break;
        case QueryResultGroupingTypeNothing:
            key = nil;
            break;
    }
    return key;
}

@end
