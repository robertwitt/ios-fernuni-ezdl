//
//  MutableLibraryChoice.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryChoice.h"

@interface MutableLibraryChoice : LibraryChoice

- (id)initWithLibraryChoice:(LibraryChoice *)libraryChoice;
- (void)selectLibrary:(Library *)library;
- (void)deselectLibrary:(Library *)library;
- (void)selectAllLibraries;
- (void)deselectAllLibraries;

@end