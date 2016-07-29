//
//  ZCTopicViewController.m
//  bsbdj
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTopicViewController.h"
#import "ZCCommentViewController.h"
#import "ZCNewViewController.h"
#import "ZCTopic.h"
#import "ZCTopicCell.h"
@interface ZCTopicViewController ()
@property (nonatomic,strong)NSMutableArray *topics;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,copy) NSString *maxtime;
@property (nonatomic,strong)NSDictionary *params;
@property (nonatomic,assign)NSInteger lastSelectedIndex;
@end
static NSString *const ZCTopCellID = @"topic";
@implementation ZCTopicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setTableView];

    [self setupRefresh];

}

- (void)setTableView
{

    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = ZCTitlesViewH+ZCTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCTopicCell class]) bundle:nil] forCellReuseIdentifier:ZCTopCellID];
    [ZCNotetCenter addObserver:self selector:@selector(tabBarSelect) name:ZCTabBarDidSelectNotification object:nil];
}

- (void)tabBarSelect
{
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && [self.view isShowingOnKeyWindow]) {
        [self.tableView.header beginRefreshing];
    }
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}
- (NSString *)a
{
    return [self.parentViewController isKindOfClass:[ZCNewViewController class]]?@"newlist":@"list";
}

- (void)setupRefresh
{

    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopicls)];
    self.tableView.header.automaticallyChangeAlpha = YES;
    [self.tableView.header beginRefreshing];

    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopicls)];
}

- (void)loadNewTopicls
{
    [self.tableView.footer endRefreshing];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;

    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params!=params)  return ;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [ZCTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        self.page = 0;


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params!=params) {
            return ;
        }
        [self.tableView.header endRefreshing];
    }];
}

- (void)loadMoreTopicls
{
    [self.tableView.header endRefreshing];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page+1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;


    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php"  parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params!=params) {
            return ;
        }
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *newTopics = [ZCTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params!=params) {
            return ;
        }
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.footer.hidden = (self.topics.count==0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    ZCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCTopCellID];

    ZCTopic *topic = self.topics[indexPath.row];

    cell.topic = topic;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCommentViewController *cvc = [[ZCCommentViewController alloc]init];
    cvc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:cvc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCTopic *topic = self.topics[indexPath.row];
    return topic.cellHight;
}

@end
