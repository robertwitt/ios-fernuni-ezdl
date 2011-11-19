//
//  CoreDataService.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@protocol CoreDataService <NSObject>

- (NSArray *)loadLibrariesWithError:(NSError **)error;
- (void)saveLibraries:(NSArray *)libraries;

@end
