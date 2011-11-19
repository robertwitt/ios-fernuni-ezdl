//
//  MockupBackendServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MockupBackendServiceImpl.h"
#import "MockupLibraryBackendService.h"

@implementation MockupBackendServiceImpl

- (NSArray *)loadLibrariesWithError:(NSError *__autoreleasing *)error
{
    MockupLibraryBackendService *service = [[MockupLibraryBackendService alloc] init];
    NSArray *libraries = [service loadLibraries];
    
    // Introduce artificial response time from Backend
    sleep(2);
    
    return libraries;
}

@end
