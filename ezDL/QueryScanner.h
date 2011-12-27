//
//  QueryScanner.h
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class QueryScanner;
@protocol QueryScannerDelegate <NSObject>

@optional
- (void)scannerDidBeginScanning:(QueryScanner *)scanner;
- (void)scannerDidEndScanning:(QueryScanner *)scanner;
- (void)scanner:(QueryScanner *)scanner didFoundWord:(NSString *)word;
- (void)scanner:(QueryScanner *)scanner didFoundConnector:(NSString *)connector;
- (void)scanner:(QueryScanner *)scanner didFoundOperator:(NSString *)operator;
- (void)scanner:(QueryScanner *)scanner didFoundNotOperator:(NSString *)operator;
- (void)scanner:(QueryScanner *)scanner didFoundQuoteSign:(NSString *)sign;
- (void)scanner:(QueryScanner *)scanner didFoundOpenBracket:(NSString *)bracket;
- (void)scanner:(QueryScanner *)scanner didFoundCloseBracket:(NSString *)bracket;

@end


@interface QueryScanner : NSObject

@property (nonatomic, weak) id<QueryScannerDelegate> delegate;

+ (QueryScanner *)scannerWithString:(NSString *)string;
- (id)initWithString:(NSString *)string;
- (void)scan;

@end
