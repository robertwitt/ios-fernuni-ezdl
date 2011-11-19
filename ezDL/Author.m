//
//  Author.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Author.h"

@implementation Author

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;

+ (Author *)authorWithFirstName:(NSString *)firstName lastName:(NSString *)lastName
{
    return [[Author alloc] initWithFirstName:firstName lastName:lastName];
}

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName
{
    self = [self initWithObjectID:nil];
    if (self) 
    {
        self.firstName = firstName;
        self.lastName = lastName;
    }
    return self;
}

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
