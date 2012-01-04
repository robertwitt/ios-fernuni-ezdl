//
//  MockupWebQueryBackendService.m
//  ezDL
//
//  Created by Robert Witt on 04.01.12.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MockupWebQueryBackendService.h"
#import "EntityFactory.h"
#import "QueryResultItem.h"
#import "ServiceFactory.h"


@interface MockupWebQueryBackendService ()

@property (nonatomic, strong) NSMutableArray *queryResultItems;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSMutableString *documentObjectID;
@property (nonatomic, strong) NSMutableString *documentTitle;
@property (nonatomic, strong) NSMutableSet *documentAuthors;
@property (nonatomic, strong) NSMutableString *documentAuthorFirstName;
@property (nonatomic, strong) NSMutableString *documentAuthorLastName;
@property (nonatomic, strong) NSMutableString *documentYear;
@property (nonatomic, strong) NSMutableString *libraryObjectID;
@property (nonatomic, strong) NSMutableString *relevance;

@end


@implementation MockupWebQueryBackendService

static NSString *ElementQueryResultItem = @"queryResultItem";
static NSString *ElementDocumentObjectID = @"id";
static NSString *ElementDocumentTitle = @"title";
static NSString *ElementDocumentAuthors = @"authors";
static NSString *ElementDocumentAuthor = @"author";
static NSString *ElementDocumentAuthorFirstName = @"firstname";
static NSString *ElementDocumentAuthorLastName = @"lastname";
static NSString *ElementDocumentYear = @"year";
static NSString *ElementLibraryObjectID = @"library";
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
    // http://www.tracelog.de:8080/ezDL/service/query/results
    
    NSData *fileData = nil;
    
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
        self.documentAuthors = [NSMutableSet set];
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
        Author *author = [[EntityFactory sharedFactory] author];
        author.firstName = self.documentAuthorFirstName;
        author.lastName = self.documentAuthorLastName;
        [self.documentAuthors addObject:author];
    }
    
    if ([elementName isEqualToString:ElementQueryResultItem])
    {
        Document *document = [[EntityFactory sharedFactory] document];
        document.dlObjectID = self.documentObjectID;
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
