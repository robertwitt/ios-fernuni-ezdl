//
//  QueryParameter.h
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryPart.h"

@interface QueryParameter : NSObject <QueryPart>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic) BOOL isNot;

@end
