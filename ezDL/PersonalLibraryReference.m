//
//  PersonalLibraryReference.m
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryReference.h"
#import "PersonalLibraryGroup.h"

@implementation PersonalLibraryReference

@synthesize document = _document;
@synthesize group = _group;
@synthesize keyWords = _keyWords;
@synthesize note = _note;

- (void)setGroup:(PersonalLibraryGroup *)group
{
    if (_group != group) {
        [_group removeReference:self];
        [group addReference:self];
        _group = group;
    }
}

@end
