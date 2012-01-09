//
//  QueryScanner.m
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryScanner.h"
#import "QueryConnector.h"
#import "QueryParameter.h"


@interface QueryScanner ()

@property (nonatomic, strong) NSString *stringToScan;

- (void)informDelegate:(SEL)message withObject:(id)object;
- (NSString *)prepareStringToScan;
- (void)didFoundCompleteString:(NSString *)string;
- (BOOL)stringIsConnector:(NSString *)string;

@end


@implementation QueryScanner

@synthesize delegate = _delegate;
@synthesize stringToScan = _stringToScan;

+ (QueryScanner *)scannerWithString:(NSString *)string {
    return [[QueryScanner alloc] initWithString:string];
}

- (id)initWithString:(NSString *)string {
    self = [self init];
    if (self) self.stringToScan = string;
    return self;
}

- (void)informDelegate:(SEL)message withObject:(id)object {
    if ([self.delegate respondsToSelector:message]) {
        [self.delegate performSelector:message 
                            withObject:self
                            withObject:object];
    }
}

- (void)scan {
    // Inform delegate about start
    [self informDelegate:@selector(scannerDidBeginScanning:) withObject:nil];
    
    NSString *string = [self prepareStringToScan];
    NSMutableString *buffer = [NSMutableString string];
    NSString *operatorBuffer = nil;
    NSCharacterSet *newlineCharacters = [NSCharacterSet newlineCharacterSet];
    
    for (int i = 0; i < string.length; i++) {
        unichar character = [string characterAtIndex:i];
        
        // Special handling for >= and <= signs. If sign buffer insn't empty and we found an
        
        if (![newlineCharacters characterIsMember:character]) {
            switch (character) {
                case '"':
                    // buffer could contain values. Send it to delegate first.
                    if (buffer.notEmpty) {
                        [self didFoundCompleteString:buffer];
                        buffer = [NSMutableString string];
                    }
                    [self informDelegate:@selector(scanner:didFoundQuoteSign:)
                              withObject:[NSString stringWithCharacters:&character length:1]];
                    break;
                    
                case '(':
                case '[':
                case '{':
                    [self informDelegate:@selector(scanner:didFoundOpenBracket:)
                              withObject:[NSString stringWithCharacters:&character length:1]];
                    break;
                    
                case ')':
                case ']':
                case '}':
                    if (buffer.notEmpty)  {
                        [self didFoundCompleteString:buffer];
                        buffer = [NSMutableString string];
                    }
                    [self informDelegate:@selector(scanner:didFoundCloseBracket:)
                              withObject:[NSString stringWithCharacters:&character length:1]];
                    break;
                    
                case ' ':
                    if (buffer.notEmpty) {
                        [self didFoundCompleteString:buffer];
                        buffer = [NSMutableString string];
                    }
                    break;
                
                case '>':
                case '<':
                    if (buffer.notEmpty) {
                        [self didFoundCompleteString:buffer];
                        buffer = [NSMutableString string];
                    }
                    
                    if ([string characterAtIndex:(i+1)] != '=') {
                        [self informDelegate:@selector(scanner:didFoundOperator:) 
                                  withObject:[NSString stringWithCharacters:&character length:1]];
                    } else {
                        // Fill buffer because after character comes '=', what make a scanner:didFoundOperator: message to early
                        operatorBuffer = [NSString stringWithCharacters:&character length:1];
                    }
                    break;
                    
                case '=': {
                    if (buffer.notEmpty) {
                        [self didFoundCompleteString:buffer];
                        buffer = [NSMutableString string];
                    }
                    
                    // Append '=' to operatorBuffer if it's filled
                    NSString *operator = [NSString stringWithCharacters:&character length:1];
                    if (operatorBuffer.notEmpty) operator = [operatorBuffer stringByAppendingString:operator];
                    [self informDelegate:@selector(scanner:didFoundOperator:) withObject:operator];
                    operatorBuffer = nil;
                    break;
                }
                    
                default:
                    [buffer appendString:[NSString stringWithCharacters:&character length:1]];
                    break;
            }
        }
    }
                 
    // Inform delegate about end
    [self informDelegate:@selector(scannerDidEndScanning:) withObject:nil];
}

- (NSString *)prepareStringToScan {
    NSString *string = [self.stringToScan stringByAppendingString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    return string;
}

- (void)didFoundCompleteString:(NSString *)string {
    SEL message = NULL;
    
    if ([self stringIsConnector:string]) {
        message = @selector(scanner:didFoundConnector:);
    } else if ([string isEqualToString:kQueryOperatorNot]) {
        message = @selector(scanner:didFoundNotOperator:);
    } else {
        message = @selector(scanner:didFoundWord:);
    }
    
    [self informDelegate:message withObject:string];
}

- (BOOL)stringIsConnector:(NSString *)string {
    return [string isEqualToString:kQueryConnectorAnd] || [string isEqualToString:kQueryConnectorOr];
}

@end
