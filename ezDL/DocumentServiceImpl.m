//
//  DocumentServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DocumentServiceImpl.h"
#import "ServiceFactory.h"

@implementation DocumentServiceImpl

- (BOOL)loadDocumentDetailInDocument:(Document *)document withError:(NSError *__autoreleasing *)error
{
    [[[ServiceFactory sharedFactory] backendService] loadDocumentDetailInDocument:document withError:error];
    return (error == nil);
}

@end
