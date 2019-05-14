//
//  PersonalLibraryGroupMO.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"


@class PersonalLibraryReference;

/*!
 @class PersonalLibraryGroup
 @abstract A group of the Personal Library in the ezDL application
 @discussion A Personal Library Group can contain a collection of PersonalLibraryReference objects.
 The class is an NSManagedObject subclass, a Core Data entity.
 */
@interface PersonalLibraryGroup : DLObject

/*!
 @property name
 @abstract Group's name
 */
@property (nonatomic, strong) NSString *name;

/*!
 @property references
 @abstract All PersonalLibraryReferences in this group
 */
@property (nonatomic, strong) NSSet *references;

@end


@interface PersonalLibraryGroup (CoreDataGeneratedAccessors)

- (void)addReferencesObject:(PersonalLibraryReference *)value;
- (void)removeReferencesObject:(PersonalLibraryReference *)value;
- (void)addReferences:(NSSet *)values;
- (void)removeReferences:(NSSet *)values;

@end
