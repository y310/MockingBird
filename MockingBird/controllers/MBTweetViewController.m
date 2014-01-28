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
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong) MBTweet *tweet;
@property (assign) BOOL isUploading;
@end

@implementation MBTweetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                            target:nil
                                                                            action:nil];
    spacer.width = 260;
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                                target:self
                                                                                action:@selector(uploadPhoto:)];
    [toolbar setItems:@[spacer, cameraItem]];
    self.tweetTextView.inputAccessoryView = toolbar;
    self.tweet = [MBTweet object];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!self.isUploading) {
        [self.tweetTextView becomeFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tweet:(id)sender {
    self.tweet.message = self.tweetTextView.text;
    self.tweet.user = [PFUser currentUser];
    [self.tweet saveEventually:^(BOOL succeeded, NSError *error) {
        if (error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MBTweetFailureNotification object:self.tweet];
        } else {
            PFPush *push = [[PFPush alloc] init];
            [push setChannel:@"message"];
            [push setData:@{@"alert":self.tweet.message, @"sound":@"default"}];
            [push sendPushInBackground];
            [[NSNotificationCenter defaultCenter] postNotificationName:MBTweetSuccessNotification object:self.tweet];
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadPhoto:(id)sender {
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePickerController setDelegate:self];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIView *uploadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    uploadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, 320, 44)];
    label.text = @"Uploading image";
    label.font = [UIFont systemFontOfSize:20.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [uploadingView addSubview:label];
    [self.navigationController.view addSubview:uploadingView];
    self.isUploading = YES;
    __weak typeof(self) weakSelf = self;
    [self.tweet setImage:image withCompletion:^{
        [uploadingView removeFromSuperview];
        weakSelf.isUploading = NO;
        [weakSelf.tweetTextView becomeFirstResponder];
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
