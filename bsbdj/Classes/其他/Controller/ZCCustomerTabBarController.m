//
//  ZCCustomerTabBarController.m
//  bsbdj
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCCustomerTabBarController.h"

#import "ZCCustomeNavigationController.h"
#import "ZCEssenceViewController.h"
#import "ZCMeViewController.h"
#import "ZCNewViewController.h"
#import "ZCFriendTrendsViewController.h"

#import "ZCTabBar.h"
@interface ZCCustomerTabBarController ()

@end

@implementation ZCCustomerTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];

    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];

    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];



    ZCEssenceViewController *evc = [[ZCEssenceViewController alloc]init];
    [self addChildVC:evc title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];

    ZCNewViewController *nvc = [[ZCNewViewController alloc]init];
    [self addChildVC:nvc title:@"最新" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];

    ZCFriendTrendsViewController *fvc = [[ZCFriendTrendsViewController alloc]init];
    [self addChildVC:fvc title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];

    ZCMeViewController *mvc = [[ZCMeViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self addChildVC:mvc title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    [self setValue:[[ZCTabBar alloc]init] forKey:@"tabBar"];

}

- (void)addChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    vc.tabBarItem.title = title;
        vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage  = [UIImage imageNamed:selectImage];
    ZCCustomeNavigationController *nvc = [[ZCCustomeNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nvc];
}



@end
