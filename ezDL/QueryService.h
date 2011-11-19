//
//  QueryService.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryChoice.h"
#import "QueryResult.h"

@protocol QueryService <NSObject>

- (LibraryChoice *)currentLibraryChoice;
- (id<Query>)buildQueryFromString:(NSString *)string;
- (id<Query>)buildQueryFromParameters:(NSDictionary *)parameters;
- (QueryResult *)executeQuery:(id<Query>)query withError:(NSError *)error;

@end
