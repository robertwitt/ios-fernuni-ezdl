//
//  AdvancedQueryViewController.m
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AdvancedQueryViewController.h"
#import "ServiceFactory.h"


@interface AdvancedQueryViewController ()

@property (nonatomic, strong) UITextField *firstResponderQueryField;

- (UITextField *)previousQueryFieldBeforeQueryField:(UITextField *)queryField;
- (UITextField *)nextQueryFieldAfterQueryField:(UITextField *)queryField;
- (void)postQueryViewGotFilledNotification;
- (void)postQueryViewGotClearedNotification;
- (BOOL)areQueryFieldsClearExcept:(UITextField *)queryField;
- (BOOL)areQueryFieldsClear:(NSArray *)queryFields;

@end

@implementation AdvancedQueryViewController

@synthesize queryText = _queryText;
@synthesize queryTitle = _queryTitle;
@synthesize queryAuthor = _queryAuthor;
@synthesize queryYear = _queryYear;
@synthesize textFieldAccessoryView = _textFieldAccessoryView;
@synthesize firstResponderQueryField = _firstResponderQueryField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSBundle mainBundle] loadNibNamed:@"AdvancedQueryTextFieldAccessoryView"
                                  owner:self
                                options:nil];
    
    self.queryText.inputAccessoryView = self.textFieldAccessoryView;
    self.queryTitle.inputAccessoryView = self.textFieldAccessoryView;
    self.queryAuthor.inputAccessoryView = self.textFieldAccessoryView;
    self.queryYear.inputAccessoryView = self.textFieldAccessoryView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.queryText.text = [self.query parameterValueFromKey:kQueryParameterKeyText];
    self.queryTitle.text = [self.query parameterValueFromKey:kQueryParameterKeyTitle];
    self.queryAuthor.text = [self.query parameterValueFromKey:kQueryParameterKeyAuthor];
    self.queryYear.text = [self.query parameterValueFromKey:kQueryParameterKeyYear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.query = [self buildQuery];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // textField became the first resonder. Store it locally for later.
    self.firstResponderQueryField = textField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL queryViewIsClear = NO;
    
    if ([self areQueryFieldsClearExcept:textField])
    {
        NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (!newText || [newText isEqualToString:@""])
        {
            [self postQueryViewGotClearedNotification];
            queryViewIsClear = YES;
        }
    }
    
    if (!queryViewIsClear) [self postQueryViewGotFilledNotification];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([self areQueryFieldsClearExcept:textField]) [self postQueryViewGotClearedNotification];
    return YES;
}

- (void)postQueryViewGotFilledNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:QueryViewGotFilledNotification
                                                        object:self];
}

- (void)postQueryViewGotClearedNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:QueryViewGotClearedNotification
                                                        object:self];
}

- (BOOL)areQueryFieldsClearExcept:(UITextField *)queryField
{
    NSMutableArray *queryFields = [NSMutableArray array];
    
    if (queryField == self.queryText)
    {
        [queryFields addObject:self.queryAuthor];
        [queryFields addObject:self.queryTitle];
        [queryFields addObject:self.queryYear];
    }
    
    if (queryField == self.queryTitle) 
    {
        [queryFields addObject:self.queryAuthor];
        [queryFields addObject:self.queryText];
        [queryFields addObject:self.queryYear];
    }
    
    if (queryField == self.queryAuthor)
    {
        [queryFields addObject:self.queryText];
        [queryFields addObject:self.queryTitle];
        [queryFields addObject:self.queryYear];
    }
    
    if (queryField == self.queryYear)
    {
        [queryFields addObject:self.queryAuthor];
        [queryFields addObject:self.queryText];
        [queryFields addObject:self.queryTitle];
    }
    
    return [self areQueryFieldsClear:queryFields];
}

- (BOOL)areQueryFieldsClear:(NSArray *)queryFields
{
    BOOL clear = YES;
    
    for (UITextField *queryField in queryFields)
    {
        if (![queryField.text isEqualToString:@""])
        {
            clear = NO;
        }
    }
    
    return clear;
}

- (IBAction)previousQueryField
{
    UITextField *previousTextField = [self previousQueryFieldBeforeQueryField:self.firstResponderQueryField];
    [self.firstResponderQueryField resignFirstResponder];
    self.firstResponderQueryField = nil;
    [previousTextField becomeFirstResponder];
}

- (UITextField *)previousQueryFieldBeforeQueryField:(UITextField *)queryField
{
    UITextField *previousField = nil;
    
    if (queryField == self.queryText) previousField = self.queryYear;
    if (queryField == self.queryTitle) previousField = self.queryText;
    if (queryField == self.queryAuthor) previousField = self.queryTitle;
    if (queryField == self.queryYear) previousField = self.queryAuthor;
    
    return previousField;
}

- (IBAction)nextQueryField
{
    UITextField *nextQueryField = [self nextQueryFieldAfterQueryField:self.firstResponderQueryField];
    [self.firstResponderQueryField resignFirstResponder];
    self.firstResponderQueryField = nil;
    [nextQueryField becomeFirstResponder];
}

- (UITextField *)nextQueryFieldAfterQueryField:(UITextField *)queryField
{
    UITextField *nextField = nil;
    
    if (queryField == self.queryText) nextField = self.queryTitle;
    if (queryField == self.queryTitle) nextField = self.queryAuthor;
    if (queryField == self.queryAuthor) nextField = self.queryYear;
    if (queryField == self.queryYear) nextField = self.queryText;
    
    return nextField;
}

- (IBAction)queryOperatorSelected:(UIBarButtonItem *)sender
{
    // TODO Actually this method should insert the operator at the cursor's current position. This, however, only appends the operator to the current text field content.
    NSString *operator = sender.title;
    NSString *text = self.firstResponderQueryField.text;
    self.firstResponderQueryField.text = [text stringByAppendingFormat:@" %@ ", operator];
}

- (id<Query>)buildQuery
{
     NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.queryAuthor.text, kQueryParameterKeyAuthor, self.queryTitle.text, kQueryParameterKeyTitle, self.queryYear.text, kQueryParameterKeyYear, self.queryText.text, kQueryParameterKeyText, nil];
    return [[[ServiceFactory sharedFactory] queryService] buildQueryFromParameters:parameters];
}

- (void)clearQueryView
{
    self.queryText.text = nil;
    self.queryTitle.text = nil;
    self.queryAuthor.text = nil;
    self.queryYear.text = nil;
}

@end
