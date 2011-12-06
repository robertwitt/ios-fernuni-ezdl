//
//  PersonalLibraryGroupMO.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"


@class PersonalLibraryReference;
@interface PersonalLibraryGroup : DLObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSSet *references;

@end


@interface PersonalLibraryGroup (CoreDataGeneratedAccessors)

- (void)addReferencesObject:(PersonalLibraryReference *)value;
- (void)removeReferencesObject:(PersonalLibraryReference *)value;
- (void)addReferences:(NSSet *)values;
- (void)removeReferences:(NSSet *)values;

@end
