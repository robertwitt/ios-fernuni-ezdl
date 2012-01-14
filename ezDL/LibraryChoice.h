//
//  LibraryChoice.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @class LibraryChoice
 @abstract Summary of selection and deselection of digital libraries
 @discussion This class encapsulates data about the digital libraries in ezDL, and furthermore which libraries the user has selected to search in.
 */
@interface LibraryChoice : NSObject

/*!
 @property selectedLibraries
 @abstract Array of digital libraries the user has selected
 */
@property (nonatomic, strong, readonly) NSArray *selectedLibraries;

/*!
 @property unselectedLibraries
 @abstract Array of digital libraries the user has not selected
 */
@property (nonatomic, strong, readonly) NSArray *unselectedLibraries;

/*!
 @property allLibraries
 @abstract Array with all digitial libraries in the ezDL application
 */
@property (nonatomic, strong, readonly) NSArray *allLibraries;

/*!
 @method initWithSelectedLibraries:unselectedLibraries:
 @abstract Initializes the LibraryChoice object
 @param selectedLibraries Array of digital libraries the user has selected
 @param unselectedLibraries Array of digital libraries the user has not selected
 */
- (id)initWithSelectedLibraries:(NSArray *)selectedLibraries unselectedLibraries:(NSArray *)unselectedLibraries;

/*!
 @method isLibrarySelected:
 @abstract Returns true if the given library has been selected by the user, otherwise false
 @param library A digital library
 @return True if the given library has been selected by the user
 */
- (BOOL)isLibrarySelected:(Library *)library;

/*!
 @method areAllLibrariesSelected
 @abstract Returns true if all available digital libraries has been selected by the user, otherwise false
 @return True if all available digital libraries has been selected by the user
 */
- (BOOL)areAllLibrariesSelected;

/*!
 @method areAllLibrariesUnselected
 @abstract Returns true if all available digital libraries are not selected by the user, otherwise false
 @return True if all available digital libraries are not selected by the user
 */
- (BOOL)areAllLibrariesUnselected;

@end
