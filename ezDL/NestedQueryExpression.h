//
//  NestedQueryExpression.h
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExpression.h"

@interface NestedQueryExpression : NSObject <QueryExpression>

@property (nonatomic, strong, readonly) NSArray *parts;

@end
