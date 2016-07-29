//
//  ZCPublishView.m
//  bsbdj
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCPublishView.h"
#import "ZCVerticalButton.h"
#import "ZCPostWordViewController.h"
#import "ZCCustomeNavigationController.h"
typedef void (^completionBlock)();
static CGFloat const ZCAnimationDelay = 0.1;
static CGFloat const ZCSpringFactor = 10;
@implementation ZCPublishView

static UIWindow *window_;
+ (void)show
{
    window_ = [[UIWindow alloc]init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:1.0];
    window_.hidden = NO;

    ZCPublishView *publishView = [ZCPublishView publishView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}

+(instancetype)publishView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:0] lastObject];
}
- (IBAction)cancell
{
    [self cancelWithCompletionBlock:nil];
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    [self addBtn];
}

- (void)addBtn
{
    self.userInteractionEnabled = NO;
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];

    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW+30;
    CGFloat buttonStartY = (ZCScreenH-2*buttonH)*0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (ZCScreenW-maxCols*buttonW-2*buttonStartX)*0.5;

    for (NSInteger i=0; i<images.count; i++) {
        ZCVerticalButton *button = [[ZCVerticalButton alloc]init];
        [self addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];

        int row = i/maxCols;
        int col = i%maxCols;

        CGFloat buttonX = buttonStartX+(xMargin+buttonW)*col;
        CGFloat buttonEndY = buttonStartY+row*buttonH;
        CGFloat buttonBeginY = buttonEndY-ZCScreenH;

        // 按钮动画

        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springSpeed =ZCSpringFactor ;
        anim.springBounciness = ZCSpringFactor;
        anim.beginTime = CACurrentMediaTime()+ZCAnimationDelay*i;
        [button pop_addAnimation:anim forKey:nil];
    }
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];

    // 标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = ZCScreenW*0.5;
    CGFloat centerEndY = ZCScreenH*0.2;
    CGFloat centerBeginY = centerEndY-ZCScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime()+images.count*ZCAnimationDelay;
    anim.springBounciness = ZCSpringFactor;
    anim.springSpeed = ZCSpringFactor;

    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];

}
// 先执行退出动画，动画完毕后执行block
- (void)cancelWithCompletionBlock:(completionBlock)block
{
    self.userInteractionEnabled = NO;
    int beginIndex = 1;
    for (NSInteger i=beginIndex; i<self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY+ZCScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime()+(i-beginIndex)*ZCAnimationDelay;
        [subView pop_addAnimation:anim forKey:nil];
        if (i==self.subviews.count-1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                window_.backgroundColor = [UIColor clearColor];
                [self removeFromSuperview];
                 window_ = nil;
                !block?:block();
            }];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}

- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        switch (button.tag) {
            case 2:{
                ZCLog(@"发段子");
                ZCPostWordViewController *pvc = [[ZCPostWordViewController alloc]init];
                 ZCCustomeNavigationController*nvc = [[ZCCustomeNavigationController alloc]initWithRootViewController:pvc];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nvc animated:YES completion:nil];
                break;
            }
            default:
                break;
        }
    }];
}

@end
