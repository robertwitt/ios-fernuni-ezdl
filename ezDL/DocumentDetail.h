//
//  DocumentDetail.h
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class DocumentLink;
@interface DocumentDetail : NSManagedObject

@property (nonatomic, strong) NSString *abstract;
@property (nonatomic, strong) NSSet *links;

@end


@interface DocumentDetail (CoreDataGeneratedAccessors)

- (void)addLinksObject:(DocumentLink *)value;
- (void)removeLinksObject:(DocumentLink *)value;
- (void)addLinks:(NSSet *)values;
- (void)removeLinks:(NSSet *)values;

@end
