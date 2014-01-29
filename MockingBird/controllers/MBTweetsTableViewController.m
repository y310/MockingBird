//
//  MBViewController.m
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "MBColorUtil.h"
#import "MBConstants.h"
#import "MBLoginViewController.h"
#import "MBTweet.h"
#import "MBTweetCell.h"
#import "MBTweetDetailViewController.h"
#import "MBTweetViewController.h"
#import "MBTweetsTableViewController.h"

@interface MBTweetsTableViewController ()
@property (strong) NSMutableArray *tweets;
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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_tweetSucceeded:)
                                                 name:MBTweetSuccessNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_tweetFailed:)
                                                 name:MBTweetFailureNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_pushReceived:)
                                                 name:MBPushNotificationReceived
                                               object:nil];

    [self.refreshControl addTarget:self
                            action:@selector(_refresh)
                  forControlEvents:UIControlEventValueChanged];

    if ([PFUser currentUser]) {
        [self _setStateLogout];
    } else {
        [self _setStateLogin];
    }
    [self _refresh];
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

- (IBAction)firstViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        MBTweetDetailViewController *controller = segue.destinationViewController;
        controller.tweet = self.tweets[[self.tableView indexPathForSelectedRow].row];
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
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [MBColorUtil defaultColor];
}

- (void)_setStateLogout
{
    self.loginOrLogoutBarButtonItem.tag = 1;
    self.loginOrLogoutBarButtonItem.title = @"Logout";
    self.navigationItem.rightBarButtonItem = self.tweetBarButtonItem;
    NSString *color = [PFUser currentUser][@"color"];
    self.navigationController.navigationBar.barTintColor = [MBColorUtil colorByName:color];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)_tweetSucceeded:(NSNotification *)notification
{
    [self _refresh];
}

- (void)_tweetFailed:(NSNotification *)notification
{
}

- (void)_pushReceived:(NSNotification *)notification
{
    NSDictionary *payload = notification.object;
    if (![payload[@"sender"] isEqualToString:[PFUser currentUser].objectId]) {
        [self _refresh];
        [PFPush handlePush:payload];
    }
}

- (void)_refresh
{
    PFQuery *query = [MBTweet query];
    [query includeKey:@"user"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.tweets removeAllObjects];
            self.tweets =  [objects mutableCopy];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
    }];
}

- (UIColor *)_defaultColor
{
    return [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
}

- (UIColor *)_blueColor
{
    return [UIColor colorWithRed:82/255.0f
                           green:179/255.0f
                            blue:179/255.0f
                           alpha:1.0f];
}

- (UIColor *)_greenColor
{
    return [UIColor colorWithRed:97/255.0f
                           green:180/255.0f
                            blue:97/255.0f
                           alpha:1.0f];
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBTweet *tweet = self.tweets[indexPath.row];
    return [MBTweetCell heightForMessage:tweet.message];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBTweet *tweet = self.tweets[indexPath.row];
    MBTweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.tweet = tweet;
    return cell;
}

@end
