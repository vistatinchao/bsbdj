//
//  ZCCommentViewController.m
//  bsbdj
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCCommentViewController.h"
#import "ZCTopic.h"
#import "ZCCommentCell.h"
#import "ZCUser.h"
#import "ZCComment.h"
#import "ZCTopicCell.h"
#import "ZCCommentHeadView.h"
@interface ZCCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (nonatomic,strong) NSArray *hotComments;
@property (nonatomic,strong) NSMutableArray *latestComments;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) ZCComment *saved_top_cmt;
@property (nonatomic,assign) NSInteger page;


@end
static NSString * const ZCCommentID = @"comment";
@implementation ZCCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBasic];

    [self setupHeader];

    [self setupRefresh];

}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)setupHeader
{
    UIView *header = [[UIView alloc]init];
    ZCLog(@"%@",self.topic.top_cmt);
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt=nil;
        [self.topic setValue:@0 forKey:@"cellHight"];
    }

    ZCTopicCell *cell = [ZCTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(ZCScreenW, self.topic.cellHight);
    [header addSubview:cell];

    header.height = self.topic.cellHight + ZCTopicCellMargin;
    self.tableView.tableHeaderView = header;
}

- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.header beginRefreshing];

    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.footer.hidden = YES;
}

- (void)loadMoreComments
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSInteger page = self.page+1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    ZCComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;



    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (![responseObject isKindOfClass:[NSDictionary class]]) {
//            self.tableView.footer.hidden = YES;
            [self.tableView.footer noticeNoMoreData];
            return;
        }
            NSArray *newComment = [ZCComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.latestComments addObjectsFromArray:newComment];
      


        self.page = page;
        [self.tableView reloadData];
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count>=total) {
            self.tableView.footer.hidden = YES;
        }
        else{
            [self.tableView.footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.footer endRefreshing];
    }];
}

- (void)loadNewComments
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";

    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.header endRefreshing];
            return ;
        }

        self.hotComments = [ZCComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [ZCComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.page = 1;
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];

        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count>=total) {
            self.tableView.footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (hotCount) {
        return 2;
    }
    if (latestCount) {
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    tableView.footer.hidden = (latestCount==0);
    if (section==0) {
        return hotCount?hotCount:latestCount;
    }
    return latestCount;
}
- (ZCComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section==0) {
        return self.hotComments.count?self.hotComments:self.latestComments;
    }
    return self.latestComments;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCCommentID];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZCCommentHeadView *header = [ZCCommentHeadView headerViewWithTableView:tableView];
    NSInteger hotCount = self.hotComments.count;
    if (section==0) {
        header.title = hotCount?@"最热评论":@"最新评论";
    }
    else{
        header.title = @"最新评论";
    }
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }
    else
    {
        ZCCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        UIMenuItem *ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];

        menu.menuItems = @[ding,replay,report];
        CGRect rect = CGRectMake(0, cell.height*0.5, cell.width, cell.height*0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}

#pragma mark menuitem处理

- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ZCLog(@"%s %@",__func__,[self commentInIndexPath:indexPath]);
}

- (void)replay:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ZCLog(@"%s %@",__func__,[self commentInIndexPath:indexPath]);
}

- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ZCLog(@"%s %@",__func__,[self commentInIndexPath:indexPath]);
}
- (void)setupBasic
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"评论";

    self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = ZCGlobalBg;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCCommentCell class]) bundle:nil] forCellReuseIdentifier:ZCCommentID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, ZCTopicCellMargin, 0);
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    CGRect frame = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    self.bottomSpace.constant = ZCScreenH-frame.origin.y;
    CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHight"];
    }
    // 取消所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
