//
//  DocumentDetail.h
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class DocumentLink;


/*!
 @class DocumentDetail
 @abstract Detailed information of a document in the ezDL application
 @discussion Some document information is separated from the Document class to allow lazy loading.
 The class is an NSManagedObject subclass, a Core Data entity.
 */
@interface DocumentDetail : NSManagedObject

/*!
 @property abstract
 @abstract The document's summary
 */
@property (nonatomic, strong) NSString *abstract;

/*!
 @property links
 @abstract Collection of additional links
 */
@property (nonatomic, strong) NSSet *links;

@end


@interface DocumentDetail (CoreDataGeneratedAccessors)

- (void)addLinksObject:(DocumentLink *)value;
- (void)removeLinksObject:(DocumentLink *)value;
- (void)addLinks:(NSSet *)values;
- (void)removeLinks:(NSSet *)values;

@end
