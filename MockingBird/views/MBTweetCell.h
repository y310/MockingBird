//
//  MBTweetCell.h
//  MockingBird
//
//  Created by mito on 2014/01/28.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBTweet;

@interface MBTweetCell : UITableViewCell
+ (CGFloat)heightForMessage:(NSString *)message;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetedAtLabel;
@property (weak, nonatomic) MBTweet *tweet;
@end
