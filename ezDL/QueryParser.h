//
//  QueryParser.h
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExpression.h"

@interface QueryParser : NSObject

- (id<QueryExpression>)parsedExpressionWithError:(NSError **)error;

@end
