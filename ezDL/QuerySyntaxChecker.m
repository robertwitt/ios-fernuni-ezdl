//
//  QuerySyntaxChecker.m
//  ezDL
//
//  Created by Robert Witt on 27.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QuerySyntaxChecker.h"
#import "QueryScanner.h"


@interface QuerySyntaxChecker () <QueryScannerDelegate>

@property (nonatomic) BOOL quoteSignsArePaired;
@property (nonatomic) NSInteger numberOfBrackets;
@property (nonatomic) BOOL result;

@end


@implementation QuerySyntaxChecker

@synthesize quoteSignsArePaired = _quoteSignsArePaired;
@synthesize numberOfBrackets = _numberOfBrackets;
@synthesize result = _result;

- (BOOL)checkString:(NSString *)string {
    QueryScanner *scanner = [QueryScanner scannerWithString:string];
    scanner.delegate = self;
    
    [scanner scan];
    
    return self.result;
}

- (void)scannerDidBeginScanning:(QueryScanner *)scanner {
    self.quoteSignsArePaired = YES;
    self.result = YES;
    self.numberOfBrackets = 0;
}

- (void)scannerDidEndScanning:(QueryScanner *)scanner {
    if (!self.quoteSignsArePaired) self.result = NO;
    if (self.numberOfBrackets != 0) self.result = NO;
}

- (void)scanner:(QueryScanner *)scanner didFoundQuoteSign:(NSString *)sign {
    self.quoteSignsArePaired = !self.quoteSignsArePaired;
}

- (void)scanner:(QueryScanner *)scanner didFoundOpenBracket:(NSString *)bracket {
    self.numberOfBrackets++;
}

- (void)scanner:(QueryScanner *)scanner didFoundCloseBracket:(NSString *)bracket {
    self.numberOfBrackets--;
}

@end
