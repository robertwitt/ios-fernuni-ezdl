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

@property (nonatomic, strong) NSOperation *executionOperation;
@property (nonatomic, strong) QueryResult *executionQueryResult;
@property (nonatomic, strong) NSError *executionError;

- (BOOL)checkQuery;
- (void)executingQueryFailedWithErrorDescription:(NSString *)string;
- (void)startExecutionOperation;
- (void)executeQuery;
- (void)executingQueryCompleted;
- (void)executingQueryFinished;

@end


@implementation QueryExecutionViewController

@synthesize queryToExecute = _queryToExecute;
@synthesize delegate = _delegate;
@synthesize executionOperation = _executionOperation;
@synthesize executionQueryResult = _executionQueryResult;
@synthesize executionError = _executionError;

#pragma mark Managing the View

- (void)viewDidUnload
{
    self.queryToExecute = nil;
    self.delegate = nil;
    self.executionOperation = nil;
    self.executionQueryResult = nil;
    self.executionError = nil;
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self checkQuery])
    {
        [self startExecutionOperation];
    }
    else
    {
        [self executingQueryFailedWithErrorDescription:NSLocalizedString(@"No Libraries Selected Text", nil)];
    }
}

- (BOOL)checkQuery
{
    BOOL ok = YES;
    
    // Return NO if no libraries has been selected.
    if ([self.queryToExecute selectedLibraries].count == 0) ok = NO;
    
    return ok;
}

- (void)executingQueryFailedWithErrorDescription:(NSString *)string
{
    NSError *error = [NSError errorWithDomain:@"Query Execution Error Domain"
                                         code:0
                                     userInfo:[NSDictionary dictionaryWithObject:string forKey:NSLocalizedDescriptionKey]];
    
    [self.delegate queryExecutionViewController:self
                          didFailExecutingQuery:self.queryToExecute
                                      withError:error];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
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
    id __block myself = self;
    [self.executionOperation setCompletionBlock:^{
        [myself executingQueryCompleted];
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:self.executionOperation];
}

- (void)executeQuery
{
    [self startNetworkActivity];
    
    // Invoke the query service to execute the query
    NSError *error = nil;
    self.executionQueryResult = [[[ServiceFactory sharedFactory] queryService] executeQuery:self.queryToExecute
                                                                                  withError:&error];
    self.executionError = error;
    
    [self stopNetworkActivity];
}

#pragma mark Finishing Query Execution

- (void)executingQueryCompleted
{
    if (![self.executionOperation isCancelled]) [self executingQueryFinished];
}

- (void)executingQueryFinished
{
    // Inform the delegate that query execution has been finished (either with or without error).
    id __block myself = self;
    
    NSBlockOperation *finishOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSError *error = [myself executionError];
        id<QueryExecutionViewControllerDelegate> delegate = [myself delegate];
        
        if (error)
        {
            [delegate queryExecutionViewController:myself 
                             didFailExecutingQuery:[myself queryToExecute] 
                                         withError:error];
        }
        else
        {
            [delegate queryExecutionViewController:myself didExecuteQueryWithQueryResult:[myself executionQueryResult]];
        }
    }];
    
    // This method is called in separated thead. Use main queue here to inform the delegate on the main thread.
    [[NSOperationQueue mainQueue] addOperation:finishOperation];
}

#pragma mark Canceling Query Execution

- (IBAction)cancel
{
    // Cancel button on UI has been pressed. Cancel the operation and inform delegate.
    [self.executionOperation cancel];
    
    [self.delegate queryExecutionViewController:self didCancelExecutingQuery:self.queryToExecute];
}

@end
