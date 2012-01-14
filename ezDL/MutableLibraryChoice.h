//
//  MutableLibraryChoice.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryChoice.h"

/*!
 @class MutableLibraryChoice
 @abstract Mutable version of the LibraryChoice class
 @discussion Additionally to LibraryChoice this class allows the selection and deselection of digital libraries after instance creation.
 */
@interface MutableLibraryChoice : LibraryChoice

/*!
 @method initWithLibraryChoice:
 @abstract Initializes a MutableLibraryChoice object with a Library Choice
 @param libraryChoice A LibraryChoice object
 @return The created MutableLibraryChoice instance
 */
- (id)initWithLibraryChoice:(LibraryChoice *)libraryChoice;

/*!
 @method selectLibrary:
 @abstract Selects the given digital library
 @param library A digital library
 */
- (void)selectLibrary:(Library *)library;

/*!
 @method deselectLibrary:
 @abstract Deselects the given digital library
 @param library A digital library
 */
- (void)deselectLibrary:(Library *)library;

/*!
 @method selectAllLibraries
 @abstract Selects all available digital libraries
 */
- (void)selectAllLibraries;

/*!
 @method deselectAllLibraries
 @abstract Deselects all available digital libraries
 */
- (void)deselectAllLibraries;

@end
