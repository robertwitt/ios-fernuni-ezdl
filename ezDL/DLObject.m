//
//  DLObject.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"

@implementation DLObject

@synthesize objectID = _objectID;

- (id)initWithObjectID:(NSString *)objectID {
    self = [self init];
    if (self) {
        _objectID = objectID;
    }
    return self;
}

@end
