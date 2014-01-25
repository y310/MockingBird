//
//  MBViewController.h
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBTweetsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loginOrLogoutBarButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *tweetBarButtonItem;
- (IBAction)logInOrLogOut:(id)sender;

@end
