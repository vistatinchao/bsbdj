//
//  ZCAddtagToobar.m
//  bsbdj
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCAddtagToobar.h"
#import "ZCAddTagViewController.h"
@interface ZCAddtagToobar()
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
@implementation ZCAddtagToobar

- (void)awakeFromNib
{
    UIButton *addButton = [[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = ZCTagMargin;
    [self.topView addSubview:addButton];
}

- (void)addButtonClick
{
    ZCAddTagViewController *vc = [[ZCAddTagViewController alloc]init];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nvc = (UINavigationController *)root.presentedViewController;
    [nvc pushViewController:vc animated:YES];
}

@end
