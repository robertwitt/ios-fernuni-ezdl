//
//  PersonalLibraryService.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroupMO.h"
#import "PersonalLibraryReferenceMO.h"
#import "DocumentMO.h"

@protocol PersonalLibraryService <NSObject>

- (PersonalLibraryGroupMO *)newGroupWithName:(NSString *)name;
- (void)saveGroup:(PersonalLibraryGroupMO *)group;
- (NSArray *)personalLibraryGroups;

- (PersonalLibraryReferenceMO *)newReferenceWithDocument:(DocumentMO *)document;
- (void)saveReference:(PersonalLibraryReferenceMO *)reference;

@end
