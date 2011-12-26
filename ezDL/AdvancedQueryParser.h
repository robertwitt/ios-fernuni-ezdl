//
//  AdvancedQueryParser.h
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryParser.h"

@interface AdvancedQueryParser : QueryParser

@property (nonatomic, strong) NSString *parameterKey;
@property (nonatomic, strong) NSString *parameterValue;

+ (id<QueryExpression>)parsedExpressionFromParameters:(NSDictionary *)parameters error:(NSError **)error;

+ (AdvancedQueryParser *)parserWithValue:(NSString *)value key:(NSString *)key;
- (id)initWithParameterValue:(NSString *)value key:(NSString *)key;

@end
