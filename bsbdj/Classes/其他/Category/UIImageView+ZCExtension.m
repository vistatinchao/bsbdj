//
//  UIImageView+ZCExtension.m
//  bsbdj
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "UIImageView+ZCExtension.h"

@implementation UIImageView (ZCExtension)
- (void)setHeader:(NSString *)url
{
    UIImage *placholder = [[UIImage imageNamed:@"defaultUserIcon"]circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image?[image circleImage]:placholder;
    }];
}
@end
