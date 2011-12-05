//
//  PersonalLibraryService.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroup.h"
#import "PersonalLibraryReference.h"
#import "Document.h"

@protocol PersonalLibraryService <NSObject>

- (PersonalLibraryGroup *)newGroupWithName:(NSString *)name;
- (void)saveGroup:(PersonalLibraryGroup *)group;
- (NSArray *)personalLibraryGroups;

- (PersonalLibraryReference *)newReferenceWithDocument:(Document *)document;
- (void)saveReference:(PersonalLibraryReference *)reference;

@end
