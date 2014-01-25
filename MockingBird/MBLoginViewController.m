//
//  MBLoginViewController.m
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "MBLoginViewController.h"

@interface MBLoginViewController ()
<PFSignUpViewControllerDelegate>
@end

@implementation MBLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.signUpController.delegate = self;
    self.signUpController.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton;
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [signUpController dismissViewControllerAnimated:YES completion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
