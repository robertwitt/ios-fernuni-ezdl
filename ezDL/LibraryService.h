//
//  LibraryService.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryChoice.h"

/*!
 @protocol LibraryService
 @abstract Service interface for managing digital libraries
 @discussion This protocols defines and collects methods to load digital libraries and manage the selection by the user. Clients must use the ServiceFactory class to get an instance.
 */
@protocol LibraryService <NSObject>

/*!
 @method libraryChoice
 @abstract Returns the digital libraries the has chosen to search in encapsulated in a LibraryChoice object.
 @return User's chosen digital libraries
 */
- (LibraryChoice *)libraryChoice;

/*!
 @method loadLibraryChoiceFromBackend:withError:
 @abstract Loads the digital libraries from ezDL backend and returns them as LibraryChoice object
 @param loadFromBackend If true, loads the libraries from ezDL backend, otherwise the service tries to load them from disk
 @param error Loading error
 @return Digital libraries as LibraryChoice collection
 */
- (LibraryChoice *)loadLibraryChoiceFromBackend:(BOOL)loadFromBackend withError:(NSError **)error;

/*!
 @method saveLibraryChoice:
 @abstract Saves the user's library choice to disk
 @param libraryChoice User's chosen digital libraries
 */
- (void)saveLibraryChoice:(LibraryChoice *)libraryChoice;

/*!
 @method libraryWithObjectID:
 @abstract Returns the digital library with the specified object ID
 @param objectID A library object ID
 @return Digital library instance
 */
- (Library *)libraryWithObjectID:(NSString *)objectID;

@end
