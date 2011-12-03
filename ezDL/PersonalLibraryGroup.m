//
//  PersonalLibraryGroup.m
//  ezDL
//
//  Created by Robert Witt on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroup.h"


@interface PersonalLibraryGroup ()

@property (nonatomic, strong) NSMutableArray *mutableReferences;

@end


@implementation PersonalLibraryGroup

@synthesize name = _name;
@synthesize mutableReferences = _mutableReferences;

- (NSArray *)references
{
    return self.mutableReferences;
}

- (NSMutableArray *)mutableReferences
{
    if (!_mutableReferences) _mutableReferences = [NSMutableArray array];
    return _mutableReferences;
}

- (void)addReference:(PersonalLibraryReference *)reference
{
    reference.group = self;
    if ([self.mutableReferences containsObject:reference]) [self.mutableReferences addObject:reference];
}

- (void)removeReference:(PersonalLibraryReference *)reference
{
    reference.group = nil;
    [self.mutableReferences removeObject:reference];
}

@end
