//
//  QueryScanner.h
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@class QueryScanner;


/*!
 @protocol QueryScannerDelegate
 @abstract Delegate of the QueryScannerDelegate class
 @discussion The delegate will be informed by the Query Scanner after it has started scanning.
 */
@protocol QueryScannerDelegate <NSObject>

@optional

/*!
 @method scannerDidBeginScanning:
 @abstract Sent to delegate if the scanner began scanning
 @param scanner The Query Scanner that sent this message
 */
- (void)scannerDidBeginScanning:(QueryScanner *)scanner;

/*!
 @method scannerDidEndScanning:
 @abstract Sent to delegate if the scanner ended scanning
 @param scanner The Query Scanner that sent this message
 */
- (void)scannerDidEndScanning:(QueryScanner *)scanner;

/*!
 @method scanner:didFoundWord:
 @abstract Sent to delegate if the scanner found a word during scanning
 @param scanner The Query Scanner that sent this message
 @param word The found word
 */
- (void)scanner:(QueryScanner *)scanner didFoundWord:(NSString *)word;

/*!
 @method scanner:didFoundConnector:
 @abstract Sent to delegate if the scanner found a connector during scanning
 @param scanner The Query Scanner that sent this message
 @param connector The found connector
 */
- (void)scanner:(QueryScanner *)scanner didFoundConnector:(NSString *)connector;

/*!
 @method scanner:didFoundOperator:
 @abstract Sent to delegate if the scanner found an operator during scanning
 @param scanner The Query Scanner that sent this message
 @param operator The found operator
 */
- (void)scanner:(QueryScanner *)scanner didFoundOperator:(NSString *)operator;

/*!
 @method scanner:didFoundNotOperator:
 @abstract Sent to delegate if the scanner found the NOT operator during scanning
 @param scanner The Query Scanner that sent this message
 @param operator The found operator
 */
- (void)scanner:(QueryScanner *)scanner didFoundNotOperator:(NSString *)operator;

/*!
 @method scanner:didFoundQuoteSign:
 @abstract Sent to delegate if the scanner found a quote sign during scanning
 @param scanner The Query Scanner that sent this message
 @param sign The found quote sign
 */
- (void)scanner:(QueryScanner *)scanner didFoundQuoteSign:(NSString *)sign;

/*!
 @method scanner:didFoundOpenBracket:
 @abstract Sent to delegate if the scanner found an open bracket during scanning
 @param scanner The Query Scanner that sent this message
 @param bracket The found bracket
 */
- (void)scanner:(QueryScanner *)scanner didFoundOpenBracket:(NSString *)bracket;

/*!
 @method scanner:didFoundCloseBracket:
 @abstract Sent to delegate if the scanner found a close bracket during scanning
 @param scanner The Query Scanner that sent this message
 @param bracket The found bracket
 */
- (void)scanner:(QueryScanner *)scanner didFoundCloseBracket:(NSString *)bracket;

@end


/*!
 @class QueryScanner
 @abstract Scanner of a query string
 @discussion Building a Query object from text a user entered is a complex process. This class scans a query string and informs clients via its delegate when it founds some interesting characters. Check out the QueryScannerDelegate protocol for more information.
 */
@interface QueryScanner : NSObject

/*!
 @property delegate
 @abstract Scanner informs this delegate during its scanning process.
 */
@property (nonatomic, weak) id<QueryScannerDelegate> delegate;

/*!
 @method scannerWithString:
 @abstract Convenience method to create a scanner with the string it should scan
 @param string String to be scanned
 @return The created QueryScanner object
 */
+ (QueryScanner *)scannerWithString:(NSString *)string;

/*!
 @method initWithString:
 @abstract Initializes a scanner with the string it should scan
 @param string String to be scanned
 @return The created QueryScanner object
 */
- (id)initWithString:(NSString *)string;

/*!
 @method scan
 @abstract Starts scanning the string the scanner has been intializes with
 */
- (void)scan;

@end
