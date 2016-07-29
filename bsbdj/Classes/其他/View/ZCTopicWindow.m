//
//  ZCTopicWindow.m
//  bsbdj
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTopicWindow.h"

@implementation ZCTopicWindow

static UIWindow *window_;
//+ (void)initialize
//{
//    window_ = [[UIWindow alloc]init];
//    window_.backgroundColor = [UIColor redColor];
//    window_.frame = CGRectMake(0, 0, ZCScreenW, 20);
//    window_.windowLevel = UIWindowLevelAlert;
//    UIViewController *emptyVC = [[UIViewController alloc]init];
//    window_.rootViewController = emptyVC;
//    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowClick)]];
//}
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}


+ (void)searchScrollViewInView:(UIView *)superView
{
    for (UIScrollView *subView in superView.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]] && [subView isShowingOnKeyWindow]) {
            CGPoint offSet = subView.contentOffset;
            offSet.y = - subView.contentInset.top;
            [subView setContentOffset:offSet animated:YES];
            break;
        }
        [self searchScrollViewInView:subView];
    }
}
#warning ios9有问题
+(void)show
{
    window_ = [[UIWindow alloc]init];
    window_.backgroundColor = [UIColor redColor];
    window_.hidden=YES;
    window_.frame = CGRectMake(0, 0, ZCScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    window_.userInteractionEnabled = YES;
    UIViewController *emptyVC = [[UIViewController alloc]init];
    window_.rootViewController = emptyVC;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowClick)]];
}



+(void)hide
{
    window_.hidden = YES;
}
@end
