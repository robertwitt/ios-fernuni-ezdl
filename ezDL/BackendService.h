//
//  BackendService.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryResult.h"

/*!
 @protocol BackendService
 @abstract Service interface for managing access to ezDL backend
 @discussion This protocols defines and collects methods to access the ezDL backend. Clients must use the ServiceFactory class to get an instance.
 */
@protocol BackendService <NSObject>

/*!
 @method loadLibrariesWithError:
 @abstract Loads all the available digital library data from ezDL backend and returns an array with Library objects
 @param error Loading error
 @return Array with digital libraries
 */
- (NSArray *)loadLibrariesWithError:(NSError **)error;

/*!
 @method executeQuery:withError:
 @abstract Calls the ezDL backend and executes a query to get a QueryResult object
 @param query A Query object
 @param error Execution error
 @return QueryResult object returned by ezDL
 */
- (QueryResult *)executeQuery:(Query *)query withError:(NSError **)error;

/*!
 @method loadDocumentDetailInDocument:withError:
 @abstract Loads the DocumentDetail object for a given document
 @param document A Document object
 @param error Loading error
 @return Loaded DocumentDetail object
 */
- (DocumentDetail *)loadDocumentDetailOfDocument:(Document *)document withError:(NSError **)error;

@end
