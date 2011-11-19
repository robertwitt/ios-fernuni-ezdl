//
//  BasicQueryViewController.h
//  ezDL
//
//  Created by Robert Witt on 18.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryViewController.h"

@interface BasicQueryViewController : QueryViewController <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *basicQuery;
@property (nonatomic, weak) IBOutlet UIView *textViewAccessoryView;

- (IBAction)queryTitleSelected;
- (IBAction)queryAuthorSelected;
- (IBAction)queryYearSelected;
- (IBAction)queryOperatorSelected:(UIBarButtonItem *)sender;

@end
