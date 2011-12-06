//
//  PersonalLibraryService.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@protocol PersonalLibraryService <NSObject>

- (PersonalLibraryGroup *)newGroupWithName:(NSString *)name;
- (void)saveGroup:(PersonalLibraryGroup *)group;
- (void)deleteGroup:(PersonalLibraryGroup *)group;
- (NSArray *)personalLibraryGroups;

- (PersonalLibraryReference *)newReferenceWithDocument:(Document *)document;
- (void)saveReference:(PersonalLibraryReference *)reference;
- (void)deleteReference:(PersonalLibraryReference *)reference;
- (void)moveReference:(PersonalLibraryReference *)reference toGroup:(PersonalLibraryGroup *)group;

@end
