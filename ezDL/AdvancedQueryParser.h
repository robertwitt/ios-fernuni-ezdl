//
//  AdvancedQueryParser.h
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryParser.h"

/*!
 @class AdvancedQueryParser
 @abstract Query parser to build a query expression from a parameter value
 @discussion This parser is supposed to be used to parse the user input in an advanced query view. It builds a query expression by a key/value parameter combination.
 */
@interface AdvancedQueryParser : QueryParser

/*!
 @property parameterKey
 @abstract A parameter key
 */
@property (nonatomic, strong) NSString *parameterKey;

/*!
 @property parameterValue
 @abstract A parameter value
 */
@property (nonatomic, strong) NSString *parameterValue;

/*!
 @method parserWithValue:key:
 @abstract Convenience method to create an AdvancedQueryParser object
 @param value A parameter value
 @param key A parameter key
 @return The created AdvancedQueryParser object
 */
+ (AdvancedQueryParser *)parserWithValue:(NSString *)value key:(NSString *)key;

/*!
 @method initWithValue:key:
 @abstract Initializes an AdvancedQueryParser object
 @param value A parameter value
 @param key A parameter key
 @return The created AdvancedQueryParser object
 */
- (id)initWithParameterValue:(NSString *)value key:(NSString *)key;

/*!
 @method parsedExpressionFromParameters:error:
 @abstract Creates a QueryExpression from a parameter dictionary or sets the error parameter if the parser weren't able to parse
 @param parameters A dictionary with key/value parameter combinations
 @param error Parsing error
 @return The parsed QueryExpression instance
 */
+ (id<QueryExpression>)parsedExpressionFromParameters:(NSDictionary *)parameters error:(NSError **)error;

@end
