//
//  MockupQueryImpl.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Query.h"

@interface MockupQueryImpl : NSObject <Query>

@property (nonatomic, strong) NSArray *selectedLibraries;
@property (nonatomic, strong) NSDate *executedOn;

- (id)initWithString:(NSString *)string;
- (id)initWithParameters:(NSDictionary *)parameters;

@end
