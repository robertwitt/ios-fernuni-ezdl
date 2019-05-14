//
//  BasicQueryViewController.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicQueryViewController.h"
#import "ServiceFactory.h"


@interface BasicQueryViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *basicQuery;
@property (nonatomic, weak) IBOutlet UIView *textViewAccessoryView;
@property (nonatomic, strong, readonly) id<QueryService> queryService;

- (IBAction)queryTitleSelected;
- (IBAction)queryAuthorSelected;
- (IBAction)queryYearSelected;
- (IBAction)queryOperatorSelected:(UIBarButtonItem *)sender;
- (void)configureAccessoryView;
- (void)addQueryParameter:(NSString *)parameter;
- (void)showBasicQueryAsCorrect;
- (void)showBasicQueryAsIncorrect;

@end


@implementation BasicQueryViewController

@synthesize basicQuery = _basicQuery;
@synthesize textViewAccessoryView = _textViewAccessoryView;
@synthesize queryService = _queryService;

#pragma mark Managing the View

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureAccessoryView];
}

- (void)configureAccessoryView {
    // Load input accessory view from nib
    [[NSBundle mainBundle] loadNibNamed:@"BasicQueryTextViewAccessoryView"
                                  owner:self
                                options:nil];
    self.basicQuery.inputAccessoryView = self.textViewAccessoryView;
}

- (void)viewDidUnload {
    self.basicQuery = nil;
    self.textViewAccessoryView = nil;
    _queryService = nil;
    [super viewDidUnload];
}

- (BOOL)resignFirstResponder {
    [self.basicQuery resignFirstResponder];
    return YES;
}

- (void)setQuery:(Query *)query {
    [super setQuery:query];
    
    // Set query string to text view outlet
    self.basicQuery.text = [self.query queryString];
}

- (void)setBasicQuery:(UITextView *)basicQuery {
    _basicQuery = basicQuery;
    _basicQuery.text = [self.query queryString];
}

- (id<QueryService>)queryService {
    if (!_queryService) _queryService = [[ServiceFactory sharedFactory] queryService];
    return _queryService;
}

#pragma mark Checking Syntax of Query

- (void)textViewDidChange:(UITextView *)textView {
    if ([self.queryService checkQuerySyntaxFromString:textView.text]) {
        [self showBasicQueryAsCorrect];
    } else {
        [self showBasicQueryAsIncorrect];
    }
}

- (void)showBasicQueryAsCorrect {
    self.basicQuery.textColor = [UIColor blackColor];
}

- (void)showBasicQueryAsIncorrect {
    self.basicQuery.textColor = [UIColor redColor];
}

- (BOOL)viewIsEmpty {
    return !self.basicQuery.text.notEmpty;
}

- (BOOL)checkQuerySyntax {
    return [self.queryService checkQuerySyntaxFromString:self.basicQuery.text];
}

#pragma mark Responding to Events on Input Accessory View

- (IBAction)queryTitleSelected {
    [self addQueryParameter:kQueryParameterKeyTitle];
}

- (IBAction)queryAuthorSelected {
    [self addQueryParameter:kQueryParameterKeyAuthor];
}

- (IBAction)queryYearSelected {
    [self addQueryParameter:kQueryParameterKeyYear];
}

- (void)addQueryParameter:(NSString *)parameter {
    // TODO Actually this method should insert the operator at the cursor's current position. This, however, only appends the operator to the current text field content.
    NSString *text = self.basicQuery.text;
    self.basicQuery.text = [text stringByAppendingFormat:@"%@=", parameter];
}

- (IBAction)queryOperatorSelected:(UIBarButtonItem *)sender {
    // TODO Actually this method should insert the operator at the cursor's current position. This, however, only appends the operator to the current text field content.
    NSString *operator = sender.title;
    NSString *text = self.basicQuery.text;
    self.basicQuery.text = [text stringByAppendingFormat:@" %@ ", operator];
}

#pragma mark Handling Query

- (Query *)buildQuery {
    // Engage query service to build a query from basic query input
    self.query = [self.queryService buildQueryFromString:self.basicQuery.text];
    return self.query;
}

- (void)clearQueryView {
    self.basicQuery.text = nil;
}

- (BOOL)canDisplayQuery:(Query *)query {
    // Every query can be displayed
    return YES;
}

@end
