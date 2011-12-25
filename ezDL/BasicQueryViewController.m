//
//  BasicQueryViewController.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicQueryViewController.h"
#import "ServiceFactory.h"


@interface BasicQueryViewController ()

- (void)addQueryParameter:(NSString *)parameter;

@end


@implementation BasicQueryViewController

@synthesize basicQuery = _basicQuery;
@synthesize textViewAccessoryView = _textViewAccessoryView;

#pragma mark Managing the View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load input accessory view from nib
    [[NSBundle mainBundle] loadNibNamed:@"BasicQueryTextViewAccessoryView"
                                  owner:self
                                options:nil];
    self.basicQuery.inputAccessoryView = self.textViewAccessoryView;
}

- (void)viewDidUnload
{
    self.basicQuery = nil;
    self.textViewAccessoryView = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Set query string to text view outlet
    self.basicQuery.text = [self.query queryString];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Build query from text view input
    //self.query = [self buildQuery];
}

- (BOOL)resignFirstResponder
{
    [self.basicQuery resignFirstResponder];
    return YES;
}

#pragma mark Sending Notification that Text has been entered/cleared

- (void)textViewDidChange:(UITextView *)textView
{
    // Basic query has been changed. Send notification that text has been entered and cleared respectively.
    if (!textView.text || [textView.text isEqualToString:@""])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:QueryViewGotClearedNotification object:self];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:QueryViewGotFilledNotification object:self];
    }
}

#pragma mark Responding to Events on Input Accessory View

- (IBAction)queryTitleSelected
{
    [self addQueryParameter:kQueryParameterKeyTitle];
}

- (IBAction)queryAuthorSelected
{
    [self addQueryParameter:kQueryParameterKeyAuthor];
}

- (IBAction)queryYearSelected
{
    [self addQueryParameter:kQueryParameterKeyYear];
}

- (void)addQueryParameter:(NSString *)parameter
{
    // TODO Actually this method should insert the operator at the cursor's current position. This, however, only appends the operator to the current text field content.
    NSString *text = self.basicQuery.text;
    self.basicQuery.text = [text stringByAppendingFormat:@"%@=", parameter];
}

- (IBAction)queryOperatorSelected:(UIBarButtonItem *)sender
{
    // TODO Actually this method should insert the operator at the cursor's current position. This, however, only appends the operator to the current text field content.
    NSString *operator = sender.title;
    NSString *text = self.basicQuery.text;
    self.basicQuery.text = [text stringByAppendingFormat:@" %@ ", operator];
}

#pragma mark Handling Query

- (id<Query>)buildQuery
{
    // Engage query service to build a query from basic query input
    return [[[ServiceFactory sharedFactory] queryService] buildQueryFromString:self.basicQuery.text];
}

- (void)clearQueryView
{
    self.basicQuery.text = nil;
}

@end
