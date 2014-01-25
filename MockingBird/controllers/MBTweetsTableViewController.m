//
//  MBViewController.m
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "MBLoginViewController.h"
#import "MBTweet.h"
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
}

- (void)_setStateLogout
{
    self.loginOrLogoutBarButtonItem.tag = 1;
    self.loginOrLogoutBarButtonItem.title = @"Logout";
    self.navigationItem.rightBarButtonItem = self.tweetBarButtonItem;
}

- (void)_tweetSucceeded:(NSNotification *)notification
{
    [self _refresh];
}

- (void)_tweetFailed:(NSNotification *)notification
{
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

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBTweet *tweet = self.tweets[indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = tweet.message;
    return cell;
}

@end
