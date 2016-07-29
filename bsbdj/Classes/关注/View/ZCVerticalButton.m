//
//  ZCVerticalButton.m
//  bsbdj
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCVerticalButton.h"

@implementation ZCVerticalButton

- (void)awakeFromNib
{
    [self setUp];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
    }
    return self;
}
- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;

    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height-self.titleLabel.y;
  

}

@end
