//
//  QueryParser.h
//  ezDL
//
//  Created by Robert Witt on 25.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExpression.h"


@interface SimpleQueryParser : NSObject

- (id<QueryExpression>)parsedExpressionFromString:(NSString *)string;
- (id<QueryExpression>)parsedExpressionFromParameters:(NSDictionary *)parameters;

@end


@interface QueryParserException : NSException
@end

@interface QueryParserSyntaxException : QueryParserException
@end