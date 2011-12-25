//
//  QueryOperator.h
//  ezDL
//
//  Created by Robert Witt on 25.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryPart.h"


enum QueryOperatorKey {
    QueryOperatorKeyAnd,
    QueryOperatorKeyOr
};

@interface QueryOperator : NSObject <QueryPart>

@property (nonatomic, readonly) enum QueryOperatorKey key;

+ (QueryOperator *)andOperator;
+ (QueryOperator *)orOperator;
- (id)initWithKey:(enum QueryOperatorKey)key;

@end
