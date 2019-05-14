//
//  DocumentService.h
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @protocol DocumentService
 @abstract Service interface for loading document details from ezDL backend
 @discussion This protocols defines and collects methods to load detailed document information from ezDL backend. Clients must use the ServiceFactory class to get an instance.
 */
@protocol DocumentService <NSObject>

/*!
 @method loadDocumentDetailInDocument:withError:
 @abstract Loads the DocumentDetail object for a given document and sets it to this object
 @param document A Document object
 @param error Loading error
 @return True if loading was successful, false otherwise
 */
- (BOOL)loadDocumentDetailInDocument:(Document *)document withError:(NSError **)error;

@end
