//
//  AuthorMO.h
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"

@interface Author : DLObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *fullName;

@end
