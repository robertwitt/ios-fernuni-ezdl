//
//  Library.h
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"

static NSString *kLibraryName = @"name";
static NSString *kLibraryShortText = @"shortText";

/*!
 @class Library
 @abstract A digital library in the ezDL application
 @discussion Digital libraries are objects where the user can search for documents.
 The class is an NSManagedObject subclass, a Core Data entity.
 */
@interface Library : DLObject

/*!
 @property name
 @abstract Library name
 */
@property (nonatomic, strong) NSString *name;

/*!
 @property shortText
 @abstract Description of the library
 */
@property (nonatomic, strong) NSString *shortText;

@end
