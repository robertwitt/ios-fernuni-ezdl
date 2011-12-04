//
//  AuthorMO.m
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthorMO.h"

@implementation AuthorMO

@dynamic firstName;
@dynamic lastName;
@dynamic fullName;

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
