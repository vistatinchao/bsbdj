//
//  ZCTextField.m
//  bsbdj
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTextField.h"
static NSString *const ZCPlaceHoledrColorKeyPath = @"_placeholderLabel.color";
@implementation ZCTextField


- (void)awakeFromNib
{
    self.tintColor = [UIColor whiteColor];
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:ZCPlaceHoledrColorKeyPath];
    return [super becomeFirstResponder];

}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:ZCPlaceHoledrColorKeyPath];
    return [super resignFirstResponder];
}

@end
