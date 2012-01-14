//
//  QueryResultItem.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @class QueryResultItem
 @abstract Item in a query result
 @discussion This class represents one line in a QueryResult object.
 */
@interface QueryResultItem : NSObject

/*!
 @property document
 @abstract Document object
 */
@property (nonatomic, strong, readonly) Document *document;

/*!
 @property library
 @abstract Digital library
 */
@property (nonatomic, strong, readonly) Library *library;

/*!
 @property relevance
 @abstract Value how much the found document matches the query
 */
@property (nonatomic, readonly) float relevance;

/*!
 @method queryResultItemWithDocument:library:relevance:
 @abstract Convenience method to create a QueryResultItem instance
 @param document The document
 @param library The digital library
 @param relevance The relevance value
 @return The created QueryResultItem objects
 */
+ (QueryResultItem *)queryResultItemWithDocument:(Document *)document library:(Library *)library relevance:(float)relevance;

/*!
 @method initWithDocument:library:relevance:
 @abstract Initializes a QueryResultItem instance
 @param document The document
 @param library The digital library
 @param relevance The relevance value
 @return The created QueryResultItem objects
 */
- (id)initWithDocument:(Document *)document library:(Library *)library relevance:(float)relevance;

@end
