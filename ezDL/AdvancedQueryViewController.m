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

@property (nonatomic, weak) UITextField *firstResponderQueryField;
@property (nonatomic, strong) id<QueryService> queryService;

- (UITextField *)previousQueryFieldBeforeQueryField:(UITextField *)queryField;
- (UITextField *)nextQueryFieldAfterQueryField:(UITextField *)queryField;
- (void)postQueryViewGotFilledNotification;
- (void)postQueryViewGotClearedNotification;
- (BOOL)areQueryFieldsClearExcept:(UITextField *)queryField;
- (BOOL)areQueryFieldsClear:(NSArray *)queryFields;
- (void)showQueryTextFieldAsCorrect:(UITextField *)textfield;
- (void)showQueryTextFieldAsIncorrect:(UITextField *)textField;

@end


@implementation AdvancedQueryViewController

@synthesize queryText = _queryText;
@synthesize queryTitle = _queryTitle;
@synthesize queryAuthor = _queryAuthor;
@synthesize queryYear = _queryYear;
@synthesize textFieldAccessoryView = _textFieldAccessoryView;
@synthesize firstResponderQueryField = _firstResponderQueryField;
@synthesize queryService = _queryService;

#pragma mark Managing the View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load input accessory views for text fields
    [[NSBundle mainBundle] loadNibNamed:@"AdvancedQueryTextFieldAccessoryView"
                                  owner:self
                                options:nil];
    
    self.queryText.inputAccessoryView = self.textFieldAccessoryView;
    self.queryTitle.inputAccessoryView = self.textFieldAccessoryView;
    self.queryAuthor.inputAccessoryView = self.textFieldAccessoryView;
    self.queryYear.inputAccessoryView = self.textFieldAccessoryView;
}

- (void)viewDidUnload
{
    self.queryText = nil;
    self.queryTitle = nil;
    self.queryAuthor = nil;
    self.queryYear = nil;
    self.textFieldAccessoryView = nil;
    self.firstResponderQueryField = nil;
    [super viewDidUnload];
}

- (BOOL)resignFirstResponder
{
    [self.queryText resignFirstResponder];
    [self.queryTitle resignFirstResponder];
    [self.queryAuthor resignFirstResponder];
    [self.queryYear resignFirstResponder];
    
    return YES;
}

- (void)setQuery:(Query *)query
{
    [super setQuery:query];
    
    // Set query parameter values to outlets
    self.queryText.text = [self.query parameterValueFromKey:kQueryParameterKeyText];
    self.queryTitle.text = [self.query parameterValueFromKey:kQueryParameterKeyTitle];
    self.queryAuthor.text = [self.query parameterValueFromKey:kQueryParameterKeyAuthor];
    self.queryYear.text = [self.query parameterValueFromKey:kQueryParameterKeyYear];
}

- (void)setQueryAuthor:(UITextField *)queryAuthor
{
    _queryAuthor = queryAuthor;
    _queryAuthor.text = [self.query parameterValueFromKey:kQueryParameterKeyAuthor];
}

- (void)setQueryText:(UITextField *)queryText
{
    _queryText = queryText;
    _queryText.text = [self.query parameterValueFromKey:kQueryParameterKeyText];
}

- (void)setQueryTitle:(UITextField *)queryTitle
{
    _queryTitle = queryTitle;
    _queryTitle.text = [self.query parameterValueFromKey:kQueryParameterKeyTitle];
}

- (void)setQueryYear:(UITextField *)queryYear
{
    _queryYear = queryYear;
    _queryYear.text = [self.query parameterValueFromKey:kQueryParameterKeyYear];
}

- (id<QueryService>)queryService
{
    if (!_queryService) _queryService = [[ServiceFactory sharedFactory] queryService];
    return _queryService;
}

#pragma mark Sending Notification that Text has been entered/cleared

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // textField became the first resonder. Store it locally for later.
    self.firstResponderQueryField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Send notification the search key in keyboard has been pressed.
    
    BOOL shouldReturn = YES;    
    if ([self areQueryFieldsClearExcept:textField]) if (!textField.text) shouldReturn = NO;
    
    if (shouldReturn)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:QueryViewSearchRequestedNotification
                                                            object:self];
    }
    
    return shouldReturn;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    // Text has been changed in one of the text fields. Send notifications that text has been entered or cleared in all text fields.
    BOOL queryViewIsClear = NO;    
    if ([self areQueryFieldsClearExcept:textField])
    {
        // All other text fields in the view except textField don't contain any text.
        if (!newText.notEmpty)
        {
            // All text fields are empty. Send the QueryViewGotClearedNotification.
            [self postQueryViewGotClearedNotification];
            queryViewIsClear = YES;
        }
    }
    
    // Otherwise if there is text in the text fields, send the QueryViewGotFilledNotification.
    if (!queryViewIsClear) [self postQueryViewGotFilledNotification];
    
    // Check syntax of this text field. Mark the text field as incorrect if the syntax is wrong.
    if ([self.queryService checkQuerySyntaxFromString:newText])
    {
        [self showQueryTextFieldAsCorrect:textField];
    }
    else
    {
        [self showQueryTextFieldAsIncorrect:textField];
    }
    
    return YES;
}

- (void)showQueryTextFieldAsCorrect:(UITextField *)textfield
{
    textfield.textColor = [UIColor blackColor];
}

- (void)showQueryTextFieldAsIncorrect:(UITextField *)textField
{
    textField.textColor = [UIColor redColor];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    // Send the QueryViewGotClearedNotification if all fields are empty now.
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
    // This method returns YES if all text fields in the view except queryField dom't contain any value.
    
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
    // Returns YES of all text fields in queryFields are empty
    BOOL clear = YES;    
    for (UITextField *queryField in queryFields)
    {
        if (queryField.text.notEmpty) clear = NO;
    }    
    return clear;
}

#pragma mark Responding to Events on Input Accessory View

- (IBAction)previousQueryField
{
    // Respond to touch event in input accessory view. Focus previous text field.
    
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
    // Respond to touch event in input accessory view. Focus next text field.
    
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

#pragma mark Handling Query

- (BOOL)checkQuerySyntax
{
    BOOL correct = YES;
    if (![self.queryService checkQuerySyntaxFromString:self.queryAuthor.text]) correct = NO;
    if (![self.queryService checkQuerySyntaxFromString:self.queryText.text]) correct = NO;
    if (![self.queryService checkQuerySyntaxFromString:self.queryTitle.text]) correct = NO;
    if (![self.queryService checkQuerySyntaxFromString:self.queryYear.text]) correct = NO;
    
    return correct;
}

- (Query *)buildQuery
{
    // Ask the query service to build a query out of text field entries in view.
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (self.queryAuthor.text.notEmpty) [parameters setObject:self.queryAuthor.text forKey:kQueryParameterKeyAuthor];
    if (self.queryText.text.notEmpty) [parameters setObject:self.queryText.text forKey:kQueryParameterKeyText];
    if (self.queryTitle.text.notEmpty) [parameters setObject:self.queryTitle.text forKey:kQueryParameterKeyTitle];
    if (self.queryYear.text.notEmpty) [parameters setObject:self.queryYear.text forKey:kQueryParameterKeyYear];
    
    if (parameters.count > 0)
    {
        // If at least one input field has been filled, build a new query.
        self.query = [self.queryService buildQueryFromParameters:parameters];
    }

    return self.query;
}

- (void)clearQueryView
{
    self.queryText.text = nil;
    self.queryTitle.text = nil;
    self.queryAuthor.text = nil;
    self.queryYear.text = nil;
}

- (BOOL)canDisplayQuery:(Query *)query
{
    // A query can be displayed in advanced search if base expression isn't deep.
    return ![query.baseExpression isDeep];
}

@end
