//
//  ZCPublishGuideView.m
//  bsbdj
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCPublishGuideView.h"

@implementation ZCPublishGuideView


+(instancetype)guideView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+(void)show
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion])
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        ZCPublishGuideView *guideView = [self guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

- (IBAction)removeGuideView
{
    [self removeFromSuperview];
}

@end
