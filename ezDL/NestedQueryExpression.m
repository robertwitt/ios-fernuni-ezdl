//
//  NestedQueryExpression.m
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NestedQueryExpression.h"


@interface NestedQueryExpression ()
@property (nonatomic, strong) NSMutableArray *mutableParts;
@end


@implementation NestedQueryExpression

@synthesize mutableParts = _mutableParts;

- (NSMutableArray *)mutableParts
{
    if (!_mutableParts) _mutableParts = [NSMutableArray array];
    return _mutableParts;
}

- (NSArray *)parts
{
    return self.mutableParts;
}

- (void)addPart:(id<QueryPart>)part
{
    [self.mutableParts addObject:part];
}

- (BOOL)isDeep
{
    // TODO Test somehow that the expression is deep
    return YES;
}

- (NSString *)parameterValueForKey:(NSString *)key
{
    // TODO Implementation needed
    return nil;
}

- (NSString *)queryString
{
    NSMutableString *string = [NSMutableString stringWithString:@"("];
    
    [self.parts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != 0) [string appendString:@" "];
        [string appendString:[obj queryString]];
    }];
    
    [string appendString:@")"];
    
    return string;
}

@end
