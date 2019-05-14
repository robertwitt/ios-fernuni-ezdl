//
//  PersonalLibraryReferenceMO.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"

@class Document, PersonalLibraryGroup;

/*!
 @class PersonalLibraryReference
 @abstract A reference of the Personal Library in the ezDL application
 @discussion A document can be stored as reference in the Personal Library.
 The class is an NSManagedObject subclass, a Core Data entity.
 */
@interface PersonalLibraryReference : DLObject

/*!
 @property keywordString
 @abstract User tags
 */
@property (nonatomic, strong) NSString *keywordString;

/*!
 @property note
 @abstract User notes
 */
@property (nonatomic, strong) NSString *note;

/*!
 @property document
 @abstract Document saved with this reference
 */
@property (nonatomic, strong) Document *document;

/*!
 @property group
 @abstract PersonalLibraryGroup the reference stored to
 */
@property (nonatomic, strong) PersonalLibraryGroup *group;

@end
