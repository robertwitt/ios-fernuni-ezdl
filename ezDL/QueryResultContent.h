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

@interface QueryResultContent : NSObject

@property (nonatomic, strong) QueryResultSorting *sorting;
@property (nonatomic, strong) QueryResultGrouping *grouping;
@property (nonatomic, strong) NSString *filterString;
@property (nonatomic, strong, readonly) NSArray *sections;
@property (nonatomic, strong, readonly) NSArray *allDocuments;

+ (QueryResultContent *)queryResultContentWithQueryResult:(QueryResult *)queryResult;
- (id)initWithQueryResult:(QueryResult *)queryResult;
- (NSString *)sectionAtIndex:(NSInteger)index;
- (NSArray *)rowsInSection:(NSString *)section;
- (NSArray *)rowsInSectionAtIndex:(NSInteger)index;
- (QueryResultRow *)rowAtIndexPath:(NSIndexPath *)indexPath;

@end
