//
//  PersonalLibraryRow.h
//  ezDL
//
//  Created by Robert Witt on 08.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface PersonalLibraryRow : NSObject

@property (nonatomic, strong, readonly) PersonalLibraryReference *reference;
@property (nonatomic, strong, readonly) NSString *documentTitle;
@property (nonatomic, strong, readonly) NSString *documentAuthorsAndYear;

+ (PersonalLibraryRow *)personalLibraryRowWithReference:(PersonalLibraryReference *)reference;
- (id)initWithReference:(PersonalLibraryReference *)reference;

@end
