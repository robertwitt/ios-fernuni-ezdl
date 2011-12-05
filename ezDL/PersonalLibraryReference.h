//
//  PersonalLibraryReferenceMO.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"

@class Document, PersonalLibraryGroup;
@interface PersonalLibraryReference : DLObject

@property (nonatomic, strong) NSString *keywordString;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) Document *document;
@property (nonatomic, strong) PersonalLibraryGroup *group;

@end
