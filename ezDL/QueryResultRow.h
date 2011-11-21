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

@interface QueryResultRow : NSObject

@property (nonatomic, strong, readonly) Document *document;
@property (nonatomic, strong, readonly) NSString *documentTitle;
@property (nonatomic, strong, readonly) NSString *documentAuthors;
@property (nonatomic, strong, readonly) NSString *documentYear;
@property (nonatomic, strong, readonly) NSString *decade;
@property (nonatomic, strong, readonly) NSString *libraryName;
@property (nonatomic, readonly) float relevance;

+ (QueryResultRow *)queryResultRowWithItem:(QueryResultItem *)item;
- (id)initWithItem:(QueryResultItem *)item;

+ (NSString *)keyOfSortingCriterion:(QueryResultSortingCriterion *)sortingCriterion;
+ (NSString *)keyOfGrouping:(QueryResultGrouping *)grouping;

@end
