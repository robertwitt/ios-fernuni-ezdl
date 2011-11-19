//
//  ServiceFactory.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BackendService.h"
#import "CoreDataService.h"
#import "LibraryService.h"
#import "QueryService.h"

@interface ServiceFactory : NSObject

+ (ServiceFactory *)sharedFactory;
- (id<QueryService>)queryService;
- (id<LibraryService>)libraryService;
- (id<CoreDataService>)coreDataService;
- (id<BackendService>)backendService;

@end
