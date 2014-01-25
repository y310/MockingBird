//
//  MBViewController.m
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "MBLoginViewController.h"
#import "MBTweetsTableViewController.h"

@interface MBTweetsTableViewController ()

@end

@implementation MBTweetsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_signupSucceeded:)
                                                 name:PFSignUpSuccessNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_loginSucceeded:)
                                                 name:PFLogInSuccessNotification
                                               object:nil];
    if ([PFUser currentUser]) {
        [self _setStateLogout];
    } else {
        [self _setStateLogin];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInOrLogOut:(UIBarButtonItem *)sender {
    if (sender.tag == 0) {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    } else {
        [PFUser logOut];
        [self _setStateLogin];
    }
}

- (void)_signupSucceeded:(NSNotification *)notification
{
    [self _setStateLogout];
}

- (void)_loginSucceeded:(NSNotification *)notification
{
    [self _setStateLogout];
    MBLoginViewController *controller = notification.object;
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)_setStateLogin
{
    self.loginOrLogoutBarButtonItem.tag = 0;
    self.loginOrLogoutBarButtonItem.title = @"Login";
}

- (void)_setStateLogout
{
    self.loginOrLogoutBarButtonItem.tag = 1;
    self.loginOrLogoutBarButtonItem.title = @"Logout";
}

@end
