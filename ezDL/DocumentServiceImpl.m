//
//  DocumentServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DocumentServiceImpl.h"
#import "EntityFactory.h"
#import "ServiceFactory.h"

@implementation DocumentServiceImpl

- (BOOL)loadDocumentDetailInDocument:(Document *)document withError:(NSError *__autoreleasing *)error {
    DocumentDetail *detail = [[[ServiceFactory sharedFactory] backendService] loadDocumentDetailOfDocument:document withError:error];
    
    [[EntityFactory sharedFactory] addDocumentDetail:detail toDocument:document];
    
    return (error == nil);
}

@end
