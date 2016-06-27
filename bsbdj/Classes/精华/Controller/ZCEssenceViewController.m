//
//  ZCEssenceViewController.m
//  bsbdj
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEssenceViewController.h"

@interface ZCEssenceViewController ()

@end

@implementation ZCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle" ]];
    self.navigationItem.titleView = imageView;

    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

- (void)tagClick
{
    ZCLog(@"点击了。。");
}

@end
