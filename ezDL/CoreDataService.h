//
//  CoreDataService.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@protocol CoreDataService <NSObject>

- (NSArray *)fetchLibrariesWithError:(NSError **)error;
- (NSArray *)saveLibraries;
- (void)deleteAllLibraries;

@end
