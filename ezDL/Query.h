//
//  Query.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

static NSString *kQueryParameterKeyAuthor = @"Author";
static NSString *kQueryParameterKeyText = @"Text";
static NSString *kQueryParameterKeyTitle = @"Title";
static NSString *kQueryParameterKeyYear = @"Year";

@protocol Query <NSObject>

- (NSArray *)selectedLibraries;
- (void)setSelectedLibraries:(NSArray *)selectedLibraries;
- (NSDate *)executedOn;
- (void)setExecutedOn:(NSDate *)executedOn;
- (NSArray *)parameterValues;
- (NSString *)parameterValueFromKey:(NSString *)key;
- (NSString *)queryString;

@end
