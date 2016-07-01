//
//  ZCNewViewController.m
//  bsbdj
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCNewViewController.h"
#import "ZCRecommendTagsViewController.h"
@interface ZCNewViewController ()

@end

@implementation ZCNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

    // 设置背景色
    self.view.backgroundColor = ZCGlobalBg;
}

- (void)tagClick
{
    ZCRecommendTagsViewController *rvc = [[ZCRecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}

@end
