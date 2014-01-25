//
//  MBTweetDetailViewController.h
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

@class MBTweet;

@interface MBTweetDetailViewController : UIViewController
@property (weak, nonatomic) MBTweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetedAtLabel;
@end
