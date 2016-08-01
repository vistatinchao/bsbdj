//
//  ZCTagTextField.m
//  bsbdj
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTagTextField.h"

@implementation ZCTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = ZCTagH;
    }
    return self;
}

- (void)deleteBackward
{
    !self.deleteBlock?:self.deleteBlock();
    [super deleteBackward];
}

@end
