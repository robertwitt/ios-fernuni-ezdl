//
//  MockupDocumentBackendService.m
//  ezDL
//
//  Created by Robert Witt on 22.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MockupDocumentBackendService.h"
#import "EntityFactory.h"


@interface MockupDocumentBackendService ()

@property (nonatomic, strong) DocumentDetail *documentDetail;
@property (nonatomic, strong) NSMutableString *documentAbstract;
@property (nonatomic, strong) NSMutableSet *documentLinks;
@property (nonatomic, strong) NSMutableString *documentLink;
@property (nonatomic, strong) NSString *currentElement;

@end


@implementation MockupDocumentBackendService

static NSString *ElementDocumentAbstract = @"docAbstract";
static NSString *ElementDocumentLink = @"docLink";

@synthesize documentDetail = _documentDetail;
@synthesize documentAbstract = _documentAbstract;
@synthesize documentLinks = _documentLinks;
@synthesize documentLink = _documentLink;
@synthesize currentElement = _currentElement;

- (DocumentDetail *)documentDetailWithDocumentObjectID:(NSString *)documentObjectID
{
    NSString *fileName = [NSString stringWithFormat:@"doc_%@", documentObjectID];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:fileData];
    parser.delegate = self;
    
    self.documentAbstract = [NSMutableString string];
    self.documentLinks = [NSMutableSet set];
    
    [parser parse];
    
    self.documentDetail = [[EntityFactory sharedFactory] documentDetail];//[[DocumentDetailBO alloc] initWithObjectID:documentObjectID];
    self.documentDetail.abstract = self.documentAbstract;
    self.documentDetail.links = self.documentLinks;
    
    return self.documentDetail;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:ElementDocumentLink]) self.documentLink = [NSMutableString string];
    
    self.currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:ElementDocumentLink])
    {
        DocumentLink *link = [[EntityFactory sharedFactory] documentLink];
        link.urlString = self.documentLink;
        [self.documentLinks addObject:link];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"  " withString:@""];
    
    if ([self.currentElement isEqualToString:ElementDocumentAbstract]) [self.documentAbstract appendString:string];
    if ([self.currentElement isEqualToString:ElementDocumentLink]) [self.documentLink appendString:string];
}

@end
