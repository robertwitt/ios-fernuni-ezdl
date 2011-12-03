//
//  PersonalLibraryReference.h
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"
#import "Document.h"

@class PersonalLibraryGroup;
@interface PersonalLibraryReference : DLObject

@property (nonatomic, strong) Document *document;
@property (nonatomic, strong) PersonalLibraryGroup *group;
@property (nonatomic, strong) NSArray *keyWords;
@property (nonatomic, strong) NSString *note;

@end
