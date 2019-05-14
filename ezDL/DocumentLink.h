//
//  DocumentLink.h
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @class DocumentLink
 @abstract A document link in the ezDL application
 @discussion The class is an NSManagedObject subclass, a Core Data entity.
 */
@interface DocumentLink : NSManagedObject

/*!
 @property urlString
 @abstract URL as string
 */
@property (nonatomic, strong) NSString *urlString;

/*!
 @property url
 @abstract URL of this link
 */
@property (nonatomic, strong, readonly) NSURL *url;

@end
