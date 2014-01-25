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

- (void)getImageWithCompletion:(void(^)(UIImage *))completion
{
    PFFile *imageFile = self[@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:imageData];
            completion(image);
        }
    }];
}

- (void)setImage:(UIImage *)image withCompletion:(void(^)())completion
{
    NSData *data = UIImagePNGRepresentation(image);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:data];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            self[@"image"] = imageFile;
        }
        completion();
    }];
}

@end
