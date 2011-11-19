//
//  QueryResult.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Query.h"

@interface QueryResult : NSObject

@property (nonatomic, strong, readonly) id<Query> query;
@property (nonatomic, strong, readonly) NSArray *items;

+ (QueryResult *)queryResultWithQuery:(id<Query>)query items:(NSArray *)items;
- (id)initWithQuery:(id<Query>)query items:(NSArray *)items;

@end
