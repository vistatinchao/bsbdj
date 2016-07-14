//
//  ZCTabBar.m
//  bsbdj
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTabBar.h"
#import "ZCPublishView.h"
@interface ZCTabBar()
@property (nonatomic,weak)UIButton *publishBtn;
@end
@implementation ZCTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addBtn];
    }
    return self;
}

- (void)addBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    self.publishBtn = btn;
}

- (void)publishClick
{
    [ZCPublishView show];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.publishBtn.bounds= CGRectMake(0, 0, self.publishBtn.currentBackgroundImage.size.width, self.publishBtn.currentBackgroundImage.size.height);
    self.publishBtn.center = CGPointMake(ZCScreenW*0.5, self.height*0.5);
    CGFloat itemY = 0;
    CGFloat itemW = self.width/5.0;
    CGFloat itemH = self.height;
    NSInteger index = 0;
    for (UIView *itemView in self.subviews)
    {
        if (![itemView isKindOfClass:[UIControl class]] || (itemView==self.publishBtn))
        {
            continue;
        }
        itemView.frame = CGRectMake(itemW*((index>1)?index+1:index), itemY, itemW, itemH);
        index++;
    }

}

@end
