//
//  ZCFriendTrendsViewController.m
//  bsbdj
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCFriendTrendsViewController.h"

@interface ZCFriendTrendsViewController ()

@end

@implementation ZCFriendTrendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";

    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];

    // 设置背景色
    self.view.backgroundColor = ZCGlobalBg;
}

- (void)friendsClick
{
   
}


@end
