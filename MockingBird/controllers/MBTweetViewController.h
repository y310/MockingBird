//
//  MBTweetViewController.h
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

extern NSString *const MBTweetSuccessNotification;
extern NSString *const MBTweetFailureNotification;

@interface MBTweetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
- (IBAction)tweet:(id)sender;
- (void)uploadPhoto:(id)sender;
@end
