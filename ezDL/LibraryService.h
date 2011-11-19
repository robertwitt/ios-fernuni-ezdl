//
//  LibraryService.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MutableLibraryChoice.h"

@protocol LibraryService <NSObject>

- (LibraryChoice *)libraryChoice;
- (LibraryChoice *)loadLibraryChoiceFromBackend:(BOOL)loadFromBackend withError:(NSError **)error;
- (void)saveLibraryChoice:(LibraryChoice *)libraryChoice;

@end
