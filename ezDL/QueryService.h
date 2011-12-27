//
//  QueryService.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryChoice.h"
#import "QueryParameter.h"
#import "QueryResult.h"

@protocol QueryService <NSObject>

- (LibraryChoice *)currentLibraryChoice;
- (BOOL)checkQuerySyntaxFromString:(NSString *)string;
- (Query *)buildQueryFromString:(NSString *)string;
- (Query *)buildQueryFromParameters:(NSDictionary *)parameters;
- (QueryResult *)executeQuery:(Query *)query withError:(NSError **)error;

@end
