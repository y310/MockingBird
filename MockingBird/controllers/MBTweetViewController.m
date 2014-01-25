//
//  MBTweetViewController.m
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "MBTweet.h"
#import "MBTweetViewController.h"

NSString *const MBTweetSuccessNotification = @"MBTweetSuccessNotification";
NSString *const MBTweetFailureNotification = @"MBTweetFailureNotification";

@interface MBTweetViewController ()

@end

@implementation MBTweetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tweetTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tweet:(id)sender {
    MBTweet *tweet = [MBTweet object];
    tweet.message = self.tweetTextView.text;
    tweet.user = [PFUser currentUser];
    [tweet saveEventually:^(BOOL succeeded, NSError *error) {
        if (error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MBTweetFailureNotification object:tweet];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:MBTweetSuccessNotification object:tweet];
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
