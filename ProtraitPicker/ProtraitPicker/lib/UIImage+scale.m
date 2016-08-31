//
//  UIImage+scale.m
//  IconClipDemo
//
//  Created by maple on 16/8/23.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "UIImage+scale.h"
#define kDefaultWidth 300.0f

@implementation UIImage (scale)

- (instancetype)scaleImage {
    if (self.size.width < kDefaultWidth) {
        return self;
    }
    //计算缩放的高
    CGFloat newHeight = kDefaultWidth * self.size.height / self.size.width;
    CGSize newSize = CGSizeMake(kDefaultWidth, newHeight);
    //开启上下文绘制
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
