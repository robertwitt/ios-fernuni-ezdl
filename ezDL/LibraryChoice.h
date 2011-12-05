//
//  LibraryChoice.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface LibraryChoice : NSObject

@property (nonatomic, strong, readonly) NSArray *selectedLibraries;
@property (nonatomic, strong, readonly) NSArray *unselectedLibraries;
@property (nonatomic, strong, readonly) NSArray *allLibraries;

- (id)initWithSelectedLibraries:(NSArray *)selectedLibraries unselectedLibraries:(NSArray *)unselectedLibraries;
- (BOOL)isLibrarySelected:(Library *)library;
- (BOOL)areAllLibrariesSelected;
- (BOOL)areAllLibrariesUnselected;

@end
