//
//  MBTweet.h
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

@interface MBTweet : PFObject<PFSubclassing>
@property (strong) NSString *message;
@property (strong) PFUser *user;
+ (NSString *)parseClassName;
@end
