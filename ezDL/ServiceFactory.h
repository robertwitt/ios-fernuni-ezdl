//
//  ServiceFactory.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BackendService.h"
#import "DocumentService.h"
#import "LibraryService.h"
#import "PersonalLibraryService.h"
#import "QueryService.h"

@interface ServiceFactory : NSObject

+ (ServiceFactory *)sharedFactory;
- (id<QueryService>)queryService;
- (id<LibraryService>)libraryService;
- (id<DocumentService>)documentService;
- (id<PersonalLibraryService>)personalLibraryService;
- (id<BackendService>)backendService;

@end
