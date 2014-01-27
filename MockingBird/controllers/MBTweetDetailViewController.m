//
//  MBTweetDetailViewController.m
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "MBTweet.h"
#import "MBTweetDetailViewController.h"

@interface MBTweetDetailViewController ()

@end

@implementation MBTweetDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.usernameLabel.text = self.tweet.user.username;
    self.messageLabel.text = self.tweet.message;
    self.tweetedAtLabel.text = self.tweet.tweetedAt;
    [self.messageLabel sizeToFit];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.tweet getImageWithCompletion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

- (void)viewDidLayoutSubviews
{
    self.scollView.contentSize = CGSizeMake(320, CGRectGetMaxY(self.imageView.frame) + 40.0f);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
