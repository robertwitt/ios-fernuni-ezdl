//
//  DocumentLink.m
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DocumentLink.h"


@implementation DocumentLink

@dynamic urlString;
@dynamic url;

- (NSURL *)url
{
    return [NSURL URLWithString:self.urlString];
}

@end
