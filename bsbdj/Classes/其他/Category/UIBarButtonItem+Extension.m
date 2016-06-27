//
//  UIBarButtonItem+Extension.m
//  bsbdj
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    Btn.size = Btn.currentBackgroundImage.size;
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[self alloc]initWithCustomView:Btn];
    return item;
}
@end
