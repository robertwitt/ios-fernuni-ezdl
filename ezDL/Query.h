//
//  Query.h
//  ezDL
//
//  Created by Robert Witt on 27.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExpression.h"

/*!
 @class Query
 @abstract Query representation in ezDL application
 @discussion This class encapsulates all data and functionality that are important for a query. It knows about the digital libraries the user has chosen to search in. In the composite pattern the Query class implements the client role. It has a property of type QueryExpression, this is the pointer to the base expression that builds this query.
 */
@interface Query : NSObject <QueryPart>

/*!
 @property baseExpression
 @abstract Base query expression
 */
@property (nonatomic, strong) id<QueryExpression> baseExpression;

/*!
 @property selectedLibraries
 @abstract Array od libraries the user has selected
 */
@property (nonatomic, strong) NSArray *selectedLibraries;

/*!
 @property executedOn
 @abstract NSDate the query was executed on 
 */
@property (nonatomic, strong) NSDate *executedOn;

/*!
 @property queryString
 @abstract String representation of this QueryPart
 */
@property (nonatomic, strong, readonly) NSString *queryString;

/*!
 @method parameterValueForKey:
 @abstract Returns the parameter value by a given key as string
 @param key A parameter key (see QueryParameter.h)
 @return Parameter value as string
 */
- (NSString *)parameterValueFromKey:(NSString *)key;

@end
