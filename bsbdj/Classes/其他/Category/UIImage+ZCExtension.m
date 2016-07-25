//
//  UIImage+ZCExtension.m
//  bsbdj
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "UIImage+ZCExtension.h"

@implementation UIImage (ZCExtension)
- (UIImage *)circleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);

    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    CGContextAddEllipseInRect(ctx, rect);

    CGContextClip(ctx);

    [self drawInRect:rect];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
