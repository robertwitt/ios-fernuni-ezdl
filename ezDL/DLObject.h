//
//  DLObject.h
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @class DLObject
 @abstract Superclass of all objects in the ezDL application
 @discussion All business object class has to derive from this class. It provides a generic interface to identify an object in the application.
 The class is an NSManagedObject subclass, a Core Data entity.
 */
@interface DLObject : NSManagedObject

/*!
 @property dlObjectID
 @abstract ID of the object in ezDL backend
 */
@property (nonatomic, strong) NSString *dlObjectID;

@end
