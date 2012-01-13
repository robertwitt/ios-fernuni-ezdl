//
//  Stack.h
//  ezDL
//
//  Created by Robert Witt on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @class Stack
 @abstract A generic stack API
 @discussion Since the iOS SDK doesn't provide a stack implementation was designed to fill this gap. It offers common methods to access on a stack.
 */
@interface Stack : NSObject

/*!
 @property size
 @abstract Number of elements in the stack
 */
@property (nonatomic, readonly) NSInteger size;

/*!
 @property empty
 @abstract True if the stack doesn't contain any elements
 */
@property (nonatomic, readonly, getter=isEmpty) BOOL empty;

/*!
 @method push:
 @abstract Pushes a new element on the top of the stack.
 @param object An object
 */
- (void)push:(id)object;

/*!
 @method pop
 @abstract Retrieves the top-most element and removes it from the stack.
 @return Top element
 */
- (id)pop;

/*!
 @method top
 @abstract Retrieves the top-most element and returns it without removing it from the stack.
 @return Top element
 */
- (id)top;

/*!
 @method clear
 @abstract Removes all elements from the stack.
 */
- (void)clear;

@end
