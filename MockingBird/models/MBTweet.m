//
//  MBTweet.m
//  MockingBird
//
//  Created by mito on 2014/01/25.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "MBTweet.h"
#import <Parse/PFObject+Subclass.h>

@implementation MBTweet
@dynamic message;
@dynamic user;

+ (NSString *)parseClassName {
    return @"Tweet";
}
@end
