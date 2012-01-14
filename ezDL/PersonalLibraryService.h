//
//  PersonalLibraryService.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @protocol PersonalLibraryService
 @abstract Service interface for managing the Personal Library
 @discussion This protocols defines and collects methods to manage the references and groups in the Personal Library. Clients must use the ServiceFactory class to get an instance.
 */
@protocol PersonalLibraryService <NSObject>

/*!
 @method newGroupWithName:
 @abstract Creates a new PersonalLibraryGroup with a given name
 @param name A group's name
 @return The new PersonalLibraryGroup instance
 */
- (PersonalLibraryGroup *)newGroupWithName:(NSString *)name;

/*!
 @method saveGroup:
 @abstract Saves a PersonalLibraryGroup object
 @param group A group in the Personal Library
 */
- (void)saveGroup:(PersonalLibraryGroup *)group;

/*!
 @method deleteGroup:
 @abstract Removes a PersonalLibraryGroup object from the Personal Library
 @param group A group in the Personal Library
 */
- (void)deleteGroup:(PersonalLibraryGroup *)group;

/*!
 @method personalLibraryGroups
 @abstract Returns an array with all groups in the Personal Library
 @return All PersonalLibraryGroup objects
 */
- (NSArray *)personalLibraryGroups;

/*!
 @method newReferenceWithDocument:
 @abstract Creates a new PersonalLibraryReference with a given document
 @param document The Document object the instance should reference to
 @return The new PersonalLibraryReference instance
 */
- (PersonalLibraryReference *)newReferenceWithDocument:(Document *)document;

/*!
 @method saveReference:
 @abstract Saves a PersonalLibraryReference object
 @param reference A reference in the Personal Library
 */
- (void)saveReference:(PersonalLibraryReference *)reference;

/*!
 @method deleteReference:
 @abstract Removes a PersonalLibraryReference object from the Personal Library
 @param reference A reference in the Personal Library
 */
- (void)deleteReference:(PersonalLibraryReference *)reference;

/*!
 @method moveReference:toGroup:
 @abstract Moves a reference into another group in the Personal Library
 @param reference A PersonalLibraryReference instance
 @param group A PersonalLibraryGroup instance
 */
- (void)moveReference:(PersonalLibraryReference *)reference toGroup:(PersonalLibraryGroup *)group;

@end
