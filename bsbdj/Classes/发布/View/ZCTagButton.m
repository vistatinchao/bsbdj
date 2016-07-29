//
//  ZCTagButton.m
//  bsbdj
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTagButton.h"

@implementation ZCTagButton


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = ZCTagBg;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width+= 3*ZCTagMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = ZCTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+ZCTagMargin;
}

@end
