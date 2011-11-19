//
//  Author.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"

@interface Author : DLObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *fullName;

+ (Author *)authorWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;
- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end
