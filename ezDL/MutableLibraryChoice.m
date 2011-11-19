//
//  MutableLibraryChoice.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MutableLibraryChoice.h"


@interface MutableLibraryChoice ()

@property (nonatomic, strong) NSMutableArray *mutableSelectedLibraries;
@property (nonatomic, strong) NSMutableArray *mutableUnselectedLibraries;

@end


@implementation MutableLibraryChoice

@synthesize mutableSelectedLibraries = _mutableSelectedLibraries;
@synthesize mutableUnselectedLibraries = _mutableUnselectedLibraries;

- (id)initWithSelectedLibraries:(NSArray *)selectedLibraries unselectedLibraries:(NSArray *)unselectedLibraries
{
    self = [super initWithSelectedLibraries:selectedLibraries unselectedLibraries:unselectedLibraries];
    if (self)
    {
        self.mutableSelectedLibraries = [NSMutableArray arrayWithArray:selectedLibraries];
        self.mutableUnselectedLibraries = [NSMutableArray arrayWithArray:unselectedLibraries];
    }
    return self;
}

- (id)initWithLibraryChoice:(LibraryChoice *)libraryChoice
{
    return [self initWithSelectedLibraries:libraryChoice.selectedLibraries unselectedLibraries:libraryChoice.unselectedLibraries];
}

- (NSArray *)selectedLibraries
{
    return self.mutableSelectedLibraries;
}

- (NSArray *)unselectedLibraries
{
    return self.mutableUnselectedLibraries;
}

- (void)selectLibrary:(Library *)library
{
    if (![self.mutableSelectedLibraries containsObject:library])
    {
        [self.mutableUnselectedLibraries removeObject:library];
        [self.mutableSelectedLibraries addObject:library];
    }
}

- (void)deselectLibrary:(Library *)library
{
    if (![self.mutableUnselectedLibraries containsObject:library])
    {
        [self.mutableSelectedLibraries removeObject:library];
        [self.mutableUnselectedLibraries addObject:library];
    }
}

- (void)selectAllLibraries
{
    NSArray *allLibraries = self.allLibraries;
    [self.mutableUnselectedLibraries removeAllObjects];
    [self.mutableSelectedLibraries removeAllObjects];
    [self.mutableSelectedLibraries addObjectsFromArray:allLibraries];
}

- (void)deselectAllLibraries
{
    NSArray *allLibraries = self.allLibraries;
    [self.mutableSelectedLibraries removeAllObjects];
    [self.mutableUnselectedLibraries removeAllObjects];
    [self.mutableUnselectedLibraries addObjectsFromArray:allLibraries];
}

@end
