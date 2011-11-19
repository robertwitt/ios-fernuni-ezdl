//
//  ServiceFactory.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryService.h"
#import "CoreDataService.h"
#import "BackendService.h"

@interface ServiceFactory : NSObject

+ (ServiceFactory *)sharedFactory;
- (id<LibraryService>)libraryService;
- (id<CoreDataService>)coreDataService;
- (id<BackendService>)backendService;

@end
