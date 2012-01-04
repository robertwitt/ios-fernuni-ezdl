//
//  Stack.m
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Stack.h"


@interface Stack ()
@property (nonatomic, strong) NSMutableArray *buffer;
@end


@implementation Stack

@synthesize buffer = _buffer;

- (NSMutableArray *)buffer {
    if (!_buffer) _buffer = [NSMutableArray array];
    return _buffer;
}

- (NSInteger)size {
    return self.buffer.count;
}

- (BOOL)isEmpty {
    return (self.size == 0);
}

- (void)push:(id)object {
    [self.buffer addObject:object];
}

- (id)pop {
    id object = [self top];
    [self.buffer removeLastObject];
    return object;
}

- (id)top {
    return [self.buffer lastObject];
}

- (void)clear {
    [self.buffer removeAllObjects];
}

@end
