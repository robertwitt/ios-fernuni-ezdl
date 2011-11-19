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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSBundle mainBundle] loadNibNamed:@"BasicQueryTextViewAccessoryView"
                                  owner:self
                                options:nil];
    self.basicQuery.inputAccessoryView = self.textViewAccessoryView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.basicQuery.text = [self.query queryString];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.query = [self buildQuery];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (!textView.text || [textView.text isEqualToString:@""])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:QueryViewGotClearedNotification object:self];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:QueryViewGotFilledNotification object:self];
    }
}

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

- (id<Query>)buildQuery
{
    return [[[ServiceFactory sharedFactory] queryService] buildQueryFromString:self.basicQuery.text];
}

- (void)clearQueryView
{
    self.basicQuery.text = nil;
}

@end
