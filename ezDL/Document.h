//
//  Document.h
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DLObject.h"


@interface DocumentDetail : DLObject

@property (nonatomic, strong) NSString *abstract;
@property (nonatomic, strong) NSArray *links;

@end


@interface Document : DLObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *authors;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) DocumentDetail *detail;

@end
