//
//  ZCRecommendTagsViewController.m
//  bsbdj
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCRecommendTagsViewController.h"
#import "ZCRecommendTag.h"
#import "ZCRecommendTagCell.h"
@interface ZCRecommendTagsViewController ()
@property (nonatomic,strong)NSArray *tags;
@end
static NSString *const ZCTagsID = @"tag";
@implementation ZCRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self loadTags];
}

- (void)setupTableView
{
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:ZCTagsID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = ZCGlobalBg;
}

- (void)loadTags
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tags = [ZCRecommendTag objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   ZCRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCTagsID];
    cell.recommendTag = self.tags[indexPath.row];

    return cell;
}


@end
