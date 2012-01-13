//
//  AuthorMO.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"

/*!
 @class Author
 @abstract An author in the ezDL application
 @discussion An author in this context is the writer/creator of a document.
 The class is an NSManagedObject subclass, a Core Data entity.
 */
@interface Author : DLObject

/*!
 @property firstName
 @abstract Author's first name
 */
@property (nonatomic, strong) NSString *firstName;

/*!
 @property lastName
 @abstract Author's last name
 */
@property (nonatomic, strong) NSString *lastName;

/*!
 @property fullName
 @abstract Author's full name
 */
@property (nonatomic, strong, readonly) NSString *fullName;

@end
