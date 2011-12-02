//
//  PersonalLibraryReferenceAddViewController.h
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Document.h"
#import "PersonalLibraryReference.h"


@class PersonalLibraryReferenceAddViewController;
@protocol PersonalLibraryReferenceAddViewControllerDelegate <NSObject>

- (void)didCancelReferenceAddViewController:(PersonalLibraryReferenceAddViewController *)viewController;
- (void)referenceAddViewController:(PersonalLibraryReferenceAddViewController *)viewController didSaveReference:(PersonalLibraryReference *)reference;

@end


@interface PersonalLibraryReferenceAddViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *keyWordsTextField;
@property (nonatomic, weak) IBOutlet UITextView *notesTextView;
@property (nonatomic, strong) Document *referenceDocument;
@property (nonatomic, weak) id<PersonalLibraryReferenceAddViewControllerDelegate> delegate;

- (IBAction)cancel;
- (IBAction)save;

@end