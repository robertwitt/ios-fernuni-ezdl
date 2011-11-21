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

@interface QueryResultGrouping : NSObject <QueryResultOption>

@property (nonatomic, readonly) enum QueryResultGroupingType groupingType;
@property (nonatomic, strong, readonly) NSString *localizedShortText;

+ (QueryResultGrouping *)authorsGrouping;
+ (QueryResultGrouping *)decadeGrouping;
+ (QueryResultGrouping *)libraryGrouping;
+ (QueryResultGrouping *)nothingGrouping;
+ (QueryResultGrouping *)queryResultGroupingWithGroupingType:(enum QueryResultGroupingType)groupingType;
- (id)initWithGroupingType:(enum QueryResultGroupingType)groupingType;

@end
