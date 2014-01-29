//
//  MBColorUtil.m
//  MockingBird
//
//  Created by mito on 2014/01/29.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "MBColorUtil.h"

@implementation MBColorUtil

+ (UIColor *)defaultColor
{
    return [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
}

+ (UIColor *)blueColor
{
    return [UIColor colorWithRed:82/255.0f
                           green:179/255.0f
                            blue:179/255.0f
                           alpha:1.0f];
}

+ (UIColor *)greenColor
{
    return [UIColor colorWithRed:97/255.0f
                           green:180/255.0f
                            blue:97/255.0f
                           alpha:1.0f];
}

+ (UIColor *)redColor
{
    return [UIColor colorWithRed:240/255.0f
                           green:100/255.0f
                            blue:100/255.0f
                           alpha:1.0f];
}

+ (UIColor *)colorByName:(NSString *)colorName
{
    if ([colorName isEqualToString:@"green"]) {
        return [self greenColor];
    } else if ([colorName isEqualToString:@"blue"]) {
        return [self blueColor];
    } else if ([colorName isEqualToString:@"red"]) {
        return [self redColor];
    } else {
        return [self defaultColor];
    }
}

@end
