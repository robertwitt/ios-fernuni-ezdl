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
    DocumentDetail *detail = [[[ServiceFactory sharedFactory] backendService] loadDocumentDetailOfDocument:document withError:error];
    
    // TODO Handle case when document is persistent. System crashes when attempting to assign transient detail to persisten document.
    document.detail = detail;
    
    return (error == nil);
}

@end
