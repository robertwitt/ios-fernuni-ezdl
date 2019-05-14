//
//  LibraryChoice.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryChoice.h"

@implementation LibraryChoice

@synthesize selectedLibraries = _selectedLibraries;
@synthesize unselectedLibraries = _unselectedLibraries;
@synthesize allLibraries = _allLibraries;

- (id)initWithSelectedLibraries:(NSArray *)selectedLibraries unselectedLibraries:(NSArray *)unselectedLibraries {
    self = [self init];
    if (self) {
        _selectedLibraries = selectedLibraries;
        _unselectedLibraries = unselectedLibraries;
    }
    return self;
}

- (NSArray *)allLibraries {
    NSMutableArray *allLibraries = [NSMutableArray arrayWithArray:self.selectedLibraries];
    [allLibraries addObjectsFromArray:self.unselectedLibraries];
    
    // Sort the array
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:kLibraryName ascending:YES];
    [allLibraries sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return allLibraries;
}

- (BOOL)isLibrarySelected:(Library *)library {
    return [self.selectedLibraries containsObject:library];
}

- (BOOL)areAllLibrariesSelected {
    return (self.selectedLibraries.count == self.allLibraries.count);
}

- (BOOL)areAllLibrariesUnselected {
    return (self.selectedLibraries.count == 0);
}

@end
