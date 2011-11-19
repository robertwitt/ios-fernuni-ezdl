//
//  LibraryMO.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

static NSString *kLibraryMOObjID = @"objID";
static NSString *kLibraryMOName = @"name";
static NSString *kLibraryMOShortDescr = @"shortDescr";

@interface LibraryMO : NSManagedObject

@property (nonatomic, strong) NSString *objID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortDescr;

@end
