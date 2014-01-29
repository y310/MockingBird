//
//  MBColorUtil.h
//  MockingBird
//
//  Created by mito on 2014/01/29.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBColorUtil : NSObject

+ (UIColor *)defaultColor;
+ (UIColor *)blueColor;
+ (UIColor *)greenColor;
+ (UIColor *)redColor;
+ (UIColor *)colorByName:(NSString *)colorName;
@end
