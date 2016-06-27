//
//  ZCMeViewController.m
//  bsbdj
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCMeViewController.h"

@interface ZCMeViewController ()

@end

@implementation ZCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
}

- (void)setNavBar
{
    // 设置导航栏标题
    self.navigationItem.title = @"我的";

    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];

    // 设置背景色
    self.view.backgroundColor = ZCGlobalBg;
}

- (void)settingClick
{

}

- (void)moonClick
{
    
}

@end
