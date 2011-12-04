//
//  PersonalLibraryGroupMO.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObjectMO.h"

@class PersonalLibraryReferenceMO;
@interface PersonalLibraryGroupMO : DLObjectMO

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSSet *references;

@end


@interface PersonalLibraryGroupMO (CoreDataGeneratedAccessors)

- (void)addReferencesObject:(PersonalLibraryReferenceMO *)value;
- (void)removeReferencesObject:(PersonalLibraryReferenceMO *)value;
- (void)addReferences:(NSSet *)values;
- (void)removeReferences:(NSSet *)values;

@end
