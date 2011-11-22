//
//  MockupQueryBackendService.m
//  ezDL
//
//  Created by Robert Witt on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MockupQueryBackendService.h"
#import "Author.h"
#import "QueryResultItem.h"
#import "ServiceFactory.h"


@interface MockupQueryBackendService ()

@property (nonatomic, strong) NSMutableArray *queryResultItems;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSMutableString *documentObjectID;
@property (nonatomic, strong) NSMutableString *documentTitle;
@property (nonatomic, strong) NSMutableArray *documentAuthors;
@property (nonatomic, strong) NSMutableString *documentAuthorFirstName;
@property (nonatomic, strong) NSMutableString *documentAuthorLastName;
@property (nonatomic, strong) NSMutableString *documentYear;
@property (nonatomic, strong) NSMutableString *libraryObjectID;
@property (nonatomic, strong) NSMutableString *relevance;

@end


@implementation MockupQueryBackendService

static NSString *ElementQueryResultItem = @"queryResultItem";
static NSString *ElementDocumentObjectID = @"docOid";
static NSString *ElementDocumentTitle = @"docTitle";
static NSString *ElementDocumentAuthors = @"docAuthors";
static NSString *ElementDocumentAuthor = @"docAuthor";
static NSString *ElementDocumentAuthorFirstName = @"authorFirstName";
static NSString *ElementDocumentAuthorLastName = @"authorLastName";
static NSString *ElementDocumentYear = @"docYear";
static NSString *ElementLibraryObjectID = @"libraryOid";
static NSString *ElementRelevance = @"relevance";

@synthesize queryResultItems = _queryResultItems;
@synthesize currentElement = _currentElement;
@synthesize documentObjectID = _documentObjectID;
@synthesize documentTitle = _documentTitle;
@synthesize documentAuthors = _documentAuthors;
@synthesize documentAuthorFirstName = _documentAuthorFirstName;
@synthesize documentAuthorLastName = _documentAuthorLastName;
@synthesize documentYear = _documentYear;
@synthesize libraryObjectID = _libraryObjectID;
@synthesize relevance = _relevance;

- (NSArray *)loadQueryResultItems
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"query_result" ofType:@"xml"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:fileData];
    parser.delegate = self;
    
    [parser parse];
    
    return self.queryResultItems;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.queryResultItems = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:ElementQueryResultItem])
    {
        self.documentObjectID = [NSMutableString string];
        self.documentTitle = [NSMutableString string];
        self.documentAuthors = [NSMutableArray array];
        self.documentYear = [NSMutableString string];
        self.libraryObjectID = [NSMutableString string];
        self.relevance = [NSMutableString string];
    }
    
    if ([elementName isEqualToString:ElementDocumentAuthor])
    {
        self.documentAuthorFirstName = [NSMutableString string];
        self.documentAuthorLastName = [NSMutableString string];
    }
    
    self.currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:ElementDocumentAuthor])
    {
        Author *author = [Author authorWithFirstName:self.documentAuthorFirstName
                                            lastName:self.documentAuthorLastName];
        [self.documentAuthors addObject:author];
    }
    
    if ([elementName isEqualToString:ElementQueryResultItem])
    {
        Document *document = [[Document alloc] initWithObjectID:self.documentObjectID];
        document.title = self.documentTitle;
        document.authors = self.documentAuthors;
        document.year = self.documentYear;
        
        Library *library = [[[ServiceFactory sharedFactory] libraryService] libraryWithObjectID:self.libraryObjectID];
        
        QueryResultItem *queryResultItem = [QueryResultItem queryResultItemWithDocument:document
                                                                                library:library
                                                                              relevance:self.relevance.floatValue];
        [self.queryResultItems addObject:queryResultItem];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"  " withString:@""];

    if ([self.currentElement isEqualToString:ElementDocumentObjectID]) [self.documentObjectID appendString:string];
    if ([self.currentElement isEqualToString:ElementDocumentTitle]) [self.documentTitle appendString:string];
    if ([self.currentElement isEqualToString:ElementDocumentAuthorFirstName]) [self.documentAuthorFirstName appendString:string];
    if ([self.currentElement isEqualToString:ElementDocumentAuthorLastName]) [self.documentAuthorLastName appendString:string];
    if ([self.currentElement isEqualToString:ElementDocumentYear]) [self.documentYear appendString:string];
    if ([self.currentElement isEqualToString:ElementLibraryObjectID]) [self.libraryObjectID appendString:string];
    if ([self.currentElement isEqualToString:ElementRelevance]) [self.relevance appendString:string];
}

@end
