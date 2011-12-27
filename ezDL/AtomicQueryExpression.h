//
//  AtomicQueryExpression.h
//  ezDL
//
//  Created by Robert Witt on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExpression.h"
#import "QueryParameter.h"

@interface AtomicQueryExpression : NSObject <QueryExpression>

@property (nonatomic, strong) QueryParameter *parameter;
@property (nonatomic, strong, readonly) NSString *queryString;
@property (nonatomic, readonly, getter=isDeep) BOOL deep;

+ (AtomicQueryExpression *)atomicExpressionWithParameterKey:(NSString *)key value:(NSString *)value;
+ (AtomicQueryExpression *)atomicExpressionWithParameterKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator;
- (id)initWithParameterKey:(NSString *)key value:(NSString *)value;
- (id)initWithParameterKey:(NSString *)key value:(NSString *)value operator:(enum QueryParameterOperator)operator;

@end
