//
//  PersonalLibraryRow.m
//  ezDL
//
//  Created by Robert Witt on 08.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryRow.h"


@interface PersonalLibraryRow ()

- (NSString *)stringFromDocumentAuthors:(NSSet *)authors year:(NSString *)year;

@end


@implementation PersonalLibraryRow

@synthesize reference = _reference;
@synthesize documentTitle = _documentTitle;
@synthesize documentAuthorsAndYear = _documentAuthorsAndYear;

+ (PersonalLibraryRow *)personalLibraryRowWithReference:(PersonalLibraryReference *)reference
{
    return [[PersonalLibraryRow alloc] initWithReference:reference];
}

- (id)initWithReference:(PersonalLibraryReference *)reference
{
    self = [self init];
    if (self) 
    {
        _reference = reference;
        _documentTitle = reference.document.title;
        _documentAuthorsAndYear = [self stringFromDocumentAuthors:reference.document.authors
                                                             year:reference.document.year];
    }
    return self;
}

- (NSString *)stringFromDocumentAuthors:(NSSet *)authors year:(NSString *)year
{
    NSMutableString *string = [NSMutableString string];
    NSArray *array = [authors allObjects];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Author *author = obj;
        if (idx == 0) [string appendString:author.fullName];
        else [string appendFormat:@"; %@", author.fullName];
    }];
    
    [string appendFormat:@" (%@)", year];
    
    return string;
}

@end
