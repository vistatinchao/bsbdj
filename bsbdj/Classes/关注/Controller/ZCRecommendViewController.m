//
//  ZCRecommendViewController.m
//  bsbdj
//
//  Created by mac on 16/6/28.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCRecommendViewController.h"
#import "ZCRecommendUserCell.h"
#import "ZCRecommendCategoryCell.h"
#import "ZCRecommendCategory.h"
#import "ZCRecommendUser.h"
#define ZCSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface ZCRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic,strong) NSArray *categories;
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) AFHTTPSessionManager *mannger;

@end

@implementation ZCRecommendViewController
static NSString * const ZCCategoryId = @"category";
static NSString * const ZCUserId = @"user";

-(AFHTTPSessionManager *)mannger
{
    if (!_mannger)
    {
        _mannger = [AFHTTPSessionManager manager];
    }
    return _mannger;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    [self loadCategories];
    [self setupRefresh];
}

- (void)loadCategories
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.mannger GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  [SVProgressHUD dismiss];
                  ZCLog(@"%@",responseObject);

                  self.categories = [ZCRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"] error:nil];
                  [self.categoryTableView reloadData];
                  [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                  [self.userTableView.header beginRefreshing];
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  [SVProgressHUD showErrorWithStatus:@"加載失敗"];
              }];
}
- (void)setTableView
{
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:ZCCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:ZCUserId];
    self.title = @"推薦關注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.categoryTableView.contentInset = self.userTableView.contentInset;
    self.userTableView.rowHeight = 70;
    self.view.backgroundColor = ZCGlobalBg;
}

- (void)setupRefresh
{
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];

}

- (void)loadMoreUsers
{
    ZCRecommendCategory *rc = ZCSelectedCategory;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.ID);
    params[@"page"] = @(++rc.currentPage);
    self.params = params;
    [self.mannger GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *users = [ZCRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [rc.users addObjectsFromArray:users];

        if (self.params!=params)return;

        [self.userTableView reloadData];

        [self chectFooterState];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params!=params)
        {
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"加載失敗"];
        [self.userTableView.footer endRefreshing];
    }];
}

- (void)loadNewUsers
{
    ZCRecommendCategory *rc = ZCSelectedCategory;
    rc.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.ID);
    params[@"page"] = @(rc.currentPage);
    self.params = params;

    [self.mannger GET:@"http://api.budejie.com/api/api_open.php" parameters:self.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *users = [ZCRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [rc.users removeAllObjects];
        [rc.users addObjectsFromArray:users];
        rc.total = [responseObject[@"total"] integerValue];
        // 不是最后一次请求
        if (self.params != params) return;
        [self.userTableView reloadData];
        [self.userTableView.header endRefreshing];
        [self chectFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params!=params)
        {
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.userTableView.header endRefreshing];
    }];
}
- (void)chectFooterState
{
    ZCRecommendCategory *rc = ZCSelectedCategory;
    self.userTableView.footer.hidden = (rc.users.count==0);
    if (rc.users.count==rc.total)
    {
        [self.userTableView.footer noticeNoMoreData];
    }
    else
    {
        [self.userTableView.footer endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.categoryTableView)
    {
        return self.categories.count;
    }
    [self chectFooterState];
    ZCRecommendCategory *rc = ZCSelectedCategory;
    return rc.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.categoryTableView)
    {
        ZCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }
    else
    {
        ZCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCUserId];
        ZCRecommendCategory *rc = ZCSelectedCategory;
        cell.user = rc.users[indexPath.row];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.header endRefreshing];
    [self.userTableView.footer endRefreshing];
    if (tableView==self.categoryTableView)
    {
        [self.userTableView reloadData];
        ZCRecommendCategory *c = self.categories[indexPath.row];
        if (c.users.count)
        {
            [self.userTableView reloadData];
        }
        else
        {
            [self.userTableView reloadData];
            [self.userTableView.header beginRefreshing];
        }


    }
}

- (void)dealloc
{
    [self.mannger.operationQueue cancelAllOperations];
}

@end
