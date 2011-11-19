//
//  Library.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Library.h"

@implementation Library

@synthesize name = _name;
@synthesize shortDescription = _shortDescription;

- (BOOL)isEqual:(id)object
{
    BOOL isEqual = NO;
    
    Library *other = (Library *)object;
    if ([self.objectID isEqualToString:other.objectID]) isEqual = YES;

    return isEqual;
}    

@end
