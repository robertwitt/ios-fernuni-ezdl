//
//  QueryConnector.h
//  ezDL
//
//  Created by Robert Witt on 25.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryPart.h"


static NSString *kQueryConnectorAnd = @"AND";
static NSString *kQueryConnectorOr = @"OR";


/*!
 @class QueryConnector
 @abstract Connector in a query
 @discussion This class is a QueryPart implementation and represents the connectors of query expressions, so AND and OR. 
 */
@interface QueryConnector : NSObject <QueryPart>

/*!
 @property identifier
 @abstract String to identify this connector
 */
@property (nonatomic, strong, readonly) NSString *identifier;

/*!
 @property queryString
 @abstract String representation of this QueryPart
 */
@property (nonatomic, strong, readonly) NSString *queryString;

/*!
 @method andConnector
 @abstract Convenience method to create a AND query connector
 @return A QueryConnector object
 */
+ (QueryConnector *)andConnector;

/*!
 @method orConnector
 @abstract Convenience method to create a OR query connector
 @return A QueryConnector object
 */
+ (QueryConnector *)orConnector;

/*!
 @method connectorWithIdentifier:
 @abstract Convenience method to create a query connector with a given identifier
 @param A query connector identifier
 @return A QueryConnector object
 */
+ (QueryConnector *)connectorWithIdentifier:(NSString *)identifier;

/*!
 @method initWithIdentifier:
 @abstract Initializes a query connector with a given identifier
 @param A query connector identifier
 @return A QueryConnector object
 */
- (id)initWithIdentifier:(NSString *)identifier;

/*!
 @method isAndConnector
 @abstract Returns true if this connector represents the AND connector, otherwise false
 @return True if connector is equals AND
 */
- (BOOL)isAndConnector;

/*!
 @method isOrConnector
 @abstract Returns true if this connector represents the OR connector, otherwise false
 @return True if connector is equals OR
 */
- (BOOL)isOrConnector;

@end
