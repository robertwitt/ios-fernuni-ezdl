//
//  PersonalLibraryGroup.h
//  ezDL
//
//  Created by Robert Witt on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"
#import "PersonalLibraryReference.h"

@interface PersonalLibraryGroup : DLObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong, readonly) NSArray *references;

- (void)addReference:(PersonalLibraryReference *)reference;
- (void)removeReference:(PersonalLibraryReference *)reference;

@end
