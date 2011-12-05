//
//  Library.h
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"

static NSString *kLibraryName = @"name";
static NSString *kLibraryShortText = @"shortText";

@interface Library : DLObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortText;

@end
