//
//  Stack.h
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface Stack : NSObject

@property (nonatomic, readonly) NSInteger size;
@property (nonatomic, readonly, getter = isEmpty) BOOL empty;

- (void)push:(id)object;
- (id)pop;
- (id)top;
- (void)clear;

@end
