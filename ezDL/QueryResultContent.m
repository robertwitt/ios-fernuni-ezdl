//
//  QueryResultContent.m
//  ezDL
//
//  Created by Robert Witt on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResultContent.h"


@interface QueryResultContent ()

@property (nonatomic, strong, readonly) NSArray *allRows;
@property (nonatomic, strong) NSArray *filteredRows;
@property (nonatomic, strong) NSMutableDictionary *groupedRows;

- (void)flattenQueryResult:(QueryResult *)queryResult;
- (NSArray *)sectionsInFilteredRows;
- (NSArray *)groupedRowsInSection:(NSString *)section;
- (NSArray *)sortRows:(NSArray *)rows;

@end


@implementation QueryResultContent

@synthesize sorting = _sorting;
@synthesize grouping = _grouping;
@synthesize filterString = _filterString;
@synthesize sections = _sections;
@synthesize allRows = _allRows;
@synthesize filteredRows = _filteredRows;
@synthesize groupedRows = _groupedRows;

+ (QueryResultContent *)queryResultContentWithQueryResult:(QueryResult *)queryResult
{
    return [[QueryResultContent alloc] initWithQueryResult:queryResult];
}

- (id)initWithQueryResult:(QueryResult *)queryResult
{
    self = [self init];
    if (self) [self flattenQueryResult:queryResult];
    return self;
}

- (void)flattenQueryResult:(QueryResult *)queryResult
{
    NSMutableArray *rows = [NSMutableArray array];
    for (QueryResultItem *item in queryResult.items)
    {
        [rows addObject:[QueryResultRow queryResultRowWithItem:item]];
    }
    _allRows = rows;
    self.filteredRows = [self.allRows copy];    
}

- (void)setFilterString:(NSString *)filterString
{
    _filterString = filterString;
    
    // TODO Do the filtering of allRows first and store result in filteredRows
    
    _sections = nil;
}

- (void)setGrouping:(QueryResultGrouping *)grouping
{
    _grouping = grouping;
    
    _sections = nil;
    self.groupedRows = [NSMutableDictionary dictionary];
}

- (void)setSorting:(QueryResultSorting *)sorting
{
    _sorting = sorting;
    
    [self.groupedRows removeObjectForKey:[QueryResultRow keyOfSortingCriterion:sorting.criterion]];
}

- (NSArray *)sections
{
    if (!_sections) _sections = [self sectionsInFilteredRows];
    return _sections;
}

- (NSArray *)sectionsInFilteredRows
{
    if (self.grouping.groupingType == QueryResultGroupingTypeNothing) return [NSArray arrayWithObject:[NSString string]];
    
    NSString *key = [QueryResultRow keyOfGrouping:self.grouping];
    NSMutableSet *sections = [NSMutableSet set];
    
    for (QueryResultRow *row in self.filteredRows)
    {
        id section = [row valueForKey:key];
        [sections addObject:section];
    }
    
    return [sections.allObjects sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSString *)sectionAtIndex:(NSInteger)index
{
    return [self.sections objectAtIndex:index];
}

- (NSArray *)rowsInSection:(NSString *)section
{
    NSArray *rows = [self.groupedRows objectForKey:section];
    if (rows) return rows;
    
    if ([section isEqualToString:@""])
    {
        rows = self.filteredRows;
    }
    else
    {
        // No values in dictionary. Determine the rows and store it in there.
        rows = [self groupedRowsInSection:section];
        [self.groupedRows setObject:rows forKey:section];
    }
    
    return [self sortRows:rows];
}

- (NSArray *)groupedRowsInSection:(NSString *)section
{
    NSMutableArray *rows = [NSMutableArray array];
    for (QueryResultRow *row in self.filteredRows)
    {
        NSString *key = [QueryResultRow keyOfGrouping:self.grouping];
        NSString *rowValue = [row valueForKey:key];
        if ([rowValue isEqualToString:section]) [rows addObject:row];
    }
    
    return rows;
}

- (NSArray *)sortRows:(NSArray *)rows
{
    NSString *key = [QueryResultRow keyOfSortingCriterion:self.sorting.criterion];
    
    BOOL ascending;
    switch (self.sorting.direction.directionType)
    {
        case QueryResultSortingDirectionTypeAscending:
            ascending = YES;
            break;
        case QueryResultSortingDirectionTypeDescending:
            ascending = NO;
            break;
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    return [rows sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (NSArray *)rowsInSectionAtIndex:(NSInteger)index
{
    NSString *section = [self sectionAtIndex:index];
    return [self rowsInSection:section];
}

- (QueryResultRow *)rowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rows = [self rowsInSectionAtIndex:indexPath.section];
    return [rows objectAtIndex:indexPath.row];
}

@end
