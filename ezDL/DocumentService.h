//
//  DocumentService.h
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@protocol DocumentService <NSObject>

- (BOOL)loadDocumentDetailInDocument:(Document *)document withError:(NSError **)error;

@end
