//
//  DocumentLink.h
//  ezDL
//
//  Created by Robert Witt on 05.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface DocumentLink : NSManagedObject

@property (nonatomic, strong) NSString  *urlString;
@property (nonatomic, strong) NSURL *url;

@end
