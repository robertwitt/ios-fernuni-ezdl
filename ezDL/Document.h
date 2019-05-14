//
//  Document.h
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"


@class Author, DocumentDetail;


/*!
 @class Document
 @abstract A document in the ezDL application
 @discussion A document in this context represents the attributes and metadata of an actual literature, i. e. it's not the text itself.
 The class is an NSManagedObject subclass, a Core Data entity.
 */
@interface Document : DLObject

/*!
 @property title
 @abstract The document's title
 */
@property (nonatomic, strong) NSString *title;

/*!
 @property year
 @abstract The year the document was published
 */
@property (nonatomic, strong) NSString *year;

/*!
 @property authors
 @abstract All Author object that have created this document
 */
@property (nonatomic, strong) NSSet *authors;

/*!
 @property detail
 @abstract Container with detailed information of this document
 */
@property (nonatomic, strong) DocumentDetail *detail;

@end


@interface Document (CoreDataGeneratedAccessors)

- (void)addAuthorsObject:(Author *)value;
- (void)removeAuthorsObject:(Author *)value;
- (void)addAuthors:(NSSet *)values;
- (void)removeAuthors:(NSSet *)values;

@end
