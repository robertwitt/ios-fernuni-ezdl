//
//  BackendService.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResult.h"

@protocol BackendService <NSObject>

- (NSArray *)loadLibrariesWithError:(NSError **)error;
- (QueryResult *)executeQuery:(id<Query>)query withError:(NSError **)error;
- (void)loadDocumentDetailInDocument:(Document *)document withError:(NSError **)error;

@end
