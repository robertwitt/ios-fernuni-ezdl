//
//  QueryExecutionViewController.m
//  ezDL
//
//  Created by Robert Witt on 20.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryExecutionViewController.h"
#import "ServiceFactory.h"


@interface QueryExecutionViewController ()

@property (nonatomic, weak) IBOutlet UITextView *queryText;
@property (nonatomic, strong) NSOperation *executionOperation;
@property (nonatomic, strong) QueryResult *executionQueryResult;
@property (nonatomic, strong) NSError *executionError;

- (IBAction)cancel;
- (BOOL)checkQuery;
- (void)executingQueryFailedWithErrorDescription:(NSString *)string;
- (void)startExecutionOperation;
- (void)executeQuery;
- (void)executingQueryCompleted;
- (void)executingQueryFinished;

@end


@implementation QueryExecutionViewController

@synthesize queryText = _queryText;
@synthesize queryToExecute = _queryToExecute;
@synthesize delegate = _delegate;
@synthesize executionOperation = _executionOperation;
@synthesize executionQueryResult = _executionQueryResult;
@synthesize executionError = _executionError;

#pragma mark Managing the View

- (void)viewDidUnload {
    self.queryText = nil;
    self.queryToExecute = nil;
    self.delegate = nil;
    self.executionOperation = nil;
    self.executionQueryResult = nil;
    self.executionError = nil;
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self checkQuery]) {
        [self startExecutionOperation];
    } else {
        [self executingQueryFailedWithErrorDescription:NSLocalizedString(@"No Libraries Selected Text", nil)];
    }
}

- (void)setQueryText:(UITextView *)queryText {
    _queryText = queryText;
    _queryText.text = self.queryToExecute.queryString;
}

- (void)setQueryToExecute:(Query *)queryToExecute {
    _queryToExecute = queryToExecute;
    self.queryText.text = queryToExecute.queryString;
}

- (BOOL)checkQuery {
    // Return NO if no libraries has been selected.
    return self.queryToExecute.selectedLibraries.notEmpty;
}

- (void)executingQueryFailedWithErrorDescription:(NSString *)string {
    NSError *error = [NSError errorWithDomain:@"Query Execution Error Domain"
                                         code:0
                                     userInfo:[NSDictionary dictionaryWithObject:string forKey:NSLocalizedDescriptionKey]];
    
    [self.delegate queryExecutionViewController:self
                          didFailExecutingQuery:self.queryToExecute
                                      withError:error];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark Executing Query as Background Task

- (void)startExecutionOperation
{
    // Build an invocation operation and adds it to an operation queue
    self.executionOperation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                   selector:@selector(executeQuery)
                                                                     object:nil];
    
    // Set completion block that's call when operation finishes or is canceled
    __weak id weakSelf = self;
    [self.executionOperation setCompletionBlock:^{
        [weakSelf executingQueryCompleted];
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:self.executionOperation];
}

- (void)executeQuery {
    [self startNetworkActivity];
    
    // Invoke the query service to execute the query
    NSError *error = nil;
    self.executionQueryResult = [[[ServiceFactory sharedFactory] queryService] executeQuery:self.queryToExecute
                                                                                  withError:&error];
    self.executionError = error;
    
    [self stopNetworkActivity];
}

#pragma mark Finishing Query Execution

- (void)executingQueryCompleted {
    if (![self.executionOperation isCancelled]) [self executingQueryFinished];
}

- (void)executingQueryFinished {
    // Inform the delegate that query execution has been finished (either with or without error).

    NSBlockOperation *finishOperation = [NSBlockOperation blockOperationWithBlock:^{
        if (self.executionError) {
            [self.delegate queryExecutionViewController:self 
                                  didFailExecutingQuery:self.queryToExecute
                                              withError:self.executionError];
        } else {
            [self.delegate queryExecutionViewController:self 
                         didExecuteQueryWithQueryResult:self.executionQueryResult];
        }
    }];
    
    // This method is called in separated thead. Use main queue here to inform the delegate on the main thread.
    [[NSOperationQueue mainQueue] addOperation:finishOperation];
}

#pragma mark Canceling Query Execution

- (IBAction)cancel {
    // Cancel button on UI has been pressed. Cancel the operation and inform delegate.
    [self.executionOperation cancel];
    
    [self.delegate queryExecutionViewController:self didCancelExecutingQuery:self.queryToExecute];
}

@end
