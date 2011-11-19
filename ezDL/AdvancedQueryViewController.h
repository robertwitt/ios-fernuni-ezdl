//
//  AdvancedQueryViewController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryViewController.h"

@interface AdvancedQueryViewController : QueryViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *queryText;
@property (nonatomic, weak) IBOutlet UITextField *queryTitle;
@property (nonatomic, weak) IBOutlet UITextField *queryAuthor;
@property (nonatomic, weak) IBOutlet UITextField *queryYear;
@property (nonatomic, weak) IBOutlet UIView *textFieldAccessoryView;

- (IBAction)previousQueryField;
- (IBAction)nextQueryField;
- (IBAction)queryOperatorSelected:(UIBarButtonItem *)sender;

@end
