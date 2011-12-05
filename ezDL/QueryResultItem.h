//
//  QueryResultItem.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface QueryResultItem : NSObject

@property (nonatomic, strong, readonly) Document *document;
@property (nonatomic, strong, readonly) Library *library;
@property (nonatomic, readonly) float relevance;

+ (QueryResultItem *)queryResultItemWithDocument:(Document *)document library:(Library *)library relevance:(float)relevance;
- (id)initWithDocument:(Document *)document library:(Library *)library relevance:(float)relevance;

@end
