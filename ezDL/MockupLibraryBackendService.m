//
//  MockupLibraryBackendService.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MockupLibraryBackendService.h"
#import "EntityFactory.h"


@interface MockupLibraryBackendService () <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *foundLibraries;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSMutableString *libraryObjectID;
@property (nonatomic, strong) NSMutableString *libraryName;
@property (nonatomic, strong) NSMutableString *libraryShortDescription;

@end


@implementation MockupLibraryBackendService

static NSString *ElementLibrary = @"library";
static NSString *ElementLibraryObjectID = @"objectID";
static NSString *ElementLibraryName = @"name";
static NSString *ElementLibraryShortDescription = @"shortText";

@synthesize foundLibraries = _foundLibraries;
@synthesize currentElement = _currentElement;
@synthesize libraryObjectID = _libraryObjectID;
@synthesize libraryName = _libraryName;
@synthesize libraryShortDescription = _libraryShortDescription;

- (NSArray *)loadLibraries {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"libraries" ofType:@"xml"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:fileData];
    parser.delegate = self;
    
    [parser parse];
    
    return self.foundLibraries;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.foundLibraries = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:ElementLibrary]) {
        self.libraryObjectID = [NSMutableString string];
        self.libraryName = [NSMutableString string];
        self.libraryShortDescription = [NSMutableString string];
    }
    
    self.currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:ElementLibrary]) {
        Library *library = [[EntityFactory sharedFactory] persistentLibrary];
        library.dlObjectID = self.libraryObjectID;
        library.name = self.libraryName;
        library.shortText = self.libraryShortDescription;
        
        [self.foundLibraries addObject:library];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.currentElement isEqualToString:ElementLibraryObjectID]) [self.libraryObjectID appendString:string];
    if ([self.currentElement isEqualToString:ElementLibraryName]) [self.libraryName appendString:string];
    if ([self.currentElement isEqualToString:ElementLibraryShortDescription]) [self.libraryShortDescription appendString:string];
}

@end
