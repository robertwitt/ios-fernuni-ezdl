//
//  PersonalLibraryReferenceMO.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObjectMO.h"

@class DocumentMO, PersonalLibraryGroupMO;
@interface PersonalLibraryReferenceMO : DLObjectMO

@property (nonatomic, strong) NSString *keywordString;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) DocumentMO *document;
@property (nonatomic, strong) PersonalLibraryGroupMO *group;

@end
