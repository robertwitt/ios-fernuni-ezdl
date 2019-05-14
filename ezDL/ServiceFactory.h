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

/*!
 @class ServiceFactory
 @abstract Factory to create service instances
 @discussion Clients must use this factory class to get an instance of a specific service.
 */
@interface ServiceFactory : NSObject

/*!
 @method sharedFactory
 @abstract Returns singleton instance of this class
 @return A ServiceFactory instance
 */
+ (ServiceFactory *)sharedFactory;

/*!
 @method queryService
 @abstract Returns a QueryService instance
 @return A Query Service
 */
- (id<QueryService>)queryService;

/*!
 @method libraryService
 @abstract Returns a LibraryService instance
 @return A Library Service
 */
- (id<LibraryService>)libraryService;

/*!
 @method documentService
 @abstract Returns a DocumentService instance
 @return A Document Service
 */
- (id<DocumentService>)documentService;

/*!
 @method personalLibraryService
 @abstract Returns a PersonalLibraryService instance
 @return A Personal Library Service
 */
- (id<PersonalLibraryService>)personalLibraryService;

/*!
 @method backendService
 @abstract Returns a BackendService instance
 @return A Backend Service
 */
- (id<BackendService>)backendService;

@end
