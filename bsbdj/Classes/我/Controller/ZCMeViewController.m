//
//  ZCMeViewController.m
//  bsbdj
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCMeViewController.h"
#import "ZCMeFootView.h"
#import "ZCMeCell.h"
@interface ZCMeViewController ()

@end

@implementation ZCMeViewController
static NSString *ZCMeID = @"me";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setupTableView];
}


- (void)setupTableView
{
    self.tableView.backgroundColor = ZCGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ZCMeCell class] forCellReuseIdentifier:ZCMeID];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = ZCTopicCellMargin;

    self.tableView.contentInset = UIEdgeInsetsMake(ZCTopicCellMargin-35, 0,0, 0);
    self.tableView.tableFooterView = [[ZCMeFootView alloc]initWithFrame:CGRectMake(0, 0, 0, 800)];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCMeID];
    if (indexPath.section==0) {
        cell.imageView.image = [UIImage imageNamed:@"mine-icon-nearby"];
        cell.textLabel.text = @"登录/注册";
    }
    else if (indexPath.section==1){
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

- (void)settingClick
{

}

- (void)moonClick
{
    
}

@end
