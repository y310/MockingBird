//
//  MBTweetCell.m
//  MockingBird
//
//  Created by mito on 2014/01/28.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "MBTweet.h"
#import "MBTweetCell.h"

@implementation MBTweetCell

+ (CGFloat)heightForMessage:(NSString *)message
{
    CGRect rect = [message boundingRectWithSize:CGSizeMake(267, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}
                                        context:nil];
    return 25.0f + rect.size.height + 5.0f + 15.0f + 5.0f;
}

- (void)setTweet:(MBTweet *)tweet
{
    _tweet = tweet;
    self.messageLabel.text = _tweet.message;
    self.usernameLabel.text = _tweet.user.username;
    self.tweetedAtLabel.text = _tweet.tweetedAt;
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [super updateConstraints];
    [self.usernameLabel sizeToFit];
    [self.messageLabel sizeToFit];
    [self.tweetedAtLabel sizeToFit];
    CGRect rect = self.tweetedAtLabel.frame;
    rect.origin.y = CGRectGetMaxY(self.messageLabel.frame) + 5.0f;
    self.tweetedAtLabel.frame = rect;
}

@end
