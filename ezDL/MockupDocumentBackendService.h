//
//  MockupDocumentBackendService.h
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface MockupDocumentBackendService : NSObject <NSXMLParserDelegate>

- (DocumentDetail *)documentDetailWithDocumentObjectID:(NSString *)documentObjectID;

@end
