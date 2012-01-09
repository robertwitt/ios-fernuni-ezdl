//
//  PersonalLibraryReferenceAddViewController.h
//  ezDL
//
//  Created by Robert Witt on 02.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryGroupAddViewController.h"


@class PersonalLibraryReferenceAddViewController;
@protocol PersonalLibraryReferenceAddViewControllerDelegate <NSObject>

- (void)didCancelReferenceAddViewController:(PersonalLibraryReferenceAddViewController *)viewController;
- (void)referenceAddViewController:(PersonalLibraryReferenceAddViewController *)viewController didSaveReference:(PersonalLibraryReference *)reference;

@end


@interface PersonalLibraryReferenceAddViewController : UIViewController

@property (nonatomic, strong) Document *referenceDocument;
@property (nonatomic, weak) id<PersonalLibraryReferenceAddViewControllerDelegate> delegate;

@end
