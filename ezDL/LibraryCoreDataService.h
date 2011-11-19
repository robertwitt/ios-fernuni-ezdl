//
//  LibraryCoreDataService.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface LibraryCoreDataService : NSObject

- (NSArray *)fetchLibrariesWithError:(NSError **)error;
- (void)saveLibraries:(NSArray *)libraries;
- (void)deleteAllLibraries;

@end
