//
//  ZCEssenceViewController.m
//  bsbdj
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEssenceViewController.h"
#import "ZCRecommendTagsViewController.h"
#import "ZCTopicViewController.h"
@interface ZCEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIView *indicatorView;
@property (nonatomic,weak) UIButton *selectedButton;
@property (nonatomic,weak) UIView *titlesView;
@property (nonatomic,weak) UIScrollView *contentView;

@end

@implementation ZCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];

    [self setupchildVces];

    [self setupTitlesView];

    [self setupContentView];

}

- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc]init];
    [self.view insertSubview:contentView atIndex:0];
    contentView.frame = self.view.bounds;
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(self.childViewControllers.count*self.view.width, 0);
    self.contentView = contentView;
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc]init];
    [self.view addSubview:titlesView];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y= 64;
    self.titlesView = titlesView;

    // 底部的红色指示器view
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height-indicatorView.height;
    self.indicatorView = indicatorView;

    // 内部的子标签
    CGFloat width = titlesView.width/self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i=0; i<self.childViewControllers.count; i++)
    {
        UIButton *button = [[UIButton alloc]init];
        [titlesView addSubview:button];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i*width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0)
        {
            button.enabled = NO;
            self.selectedButton = button;
            // 让按钮内部的文字根据文字内容来计算
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titlesView addSubview:self.indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;

    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag*self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

- (void)setupchildVces
{
    ZCTopicViewController *word = [[ZCTopicViewController alloc]init];
    word.title = @"段子";
    word.type = ZCTopicTypeWord;
    [self addChildViewController:word];

    ZCTopicViewController *all = [[ZCTopicViewController alloc]init];
    all.title = @"全部";
    all.type = ZCTopicTypeAll;
    [self addChildViewController:all];

    ZCTopicViewController *picture = [[ZCTopicViewController alloc]init];
    picture.title = @"图片";
    picture.type = ZCTopicTypePicture;
    [self addChildViewController:picture];

    ZCTopicViewController *video = [[ZCTopicViewController alloc]init];
    video.title = @"视频";
    video.type = ZCTopicTypeVideo;
    [self addChildViewController:video];

    ZCTopicViewController *voice = [[ZCTopicViewController alloc]init];
    voice.title = @"声音";
    voice.type = ZCTopicTypeVoice;
    [self addChildViewController:voice];
}


- (void)setupNav
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle" ]];
    self.navigationItem.titleView = imageView;

    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

    self.view.backgroundColor = ZCGlobalBg;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前索引
    NSInteger index = scrollView.contentOffset.x/self.view.width;
    // 取出自控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = index*scrollView.width;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x/self.view.width;
    [self titleClick:self.titlesView.subviews[index]];
}



- (void)tagClick
{
    ZCRecommendTagsViewController *rvc = [[ZCRecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}

@end
