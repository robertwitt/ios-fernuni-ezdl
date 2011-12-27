//
//  Query.h
//  ezDL
//
//  Created by Robert Witt on 27.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExpression.h"

@interface Query : NSObject <QueryPart>

@property (nonatomic, strong) id<QueryExpression> baseExpression;
@property (nonatomic, strong) NSArray *selectedLibraries;
@property (nonatomic, strong) NSDate *executedOn;
@property (nonatomic, strong, readonly) NSString *queryString;

- (NSString *)parameterValueFromKey:(NSString *)key;

@end
