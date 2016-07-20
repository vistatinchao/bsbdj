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
@interface ZCCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (nonatomic,strong) NSArray *hotComments;
@property (nonatomic,strong) NSMutableArray *latestComments;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end
static NSString * const ZCCommentID = @"comment";
@implementation ZCCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];


}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCCommentID];
    cell.textLabel.text = [NSString stringWithFormat:@"wwwwww"];
    return cell;
}
- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = ZCGlobalBg;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCCommentCell class]) bundle:nil] forCellReuseIdentifier:ZCCommentID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, ZCTopicCellMargin, 0);
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

}
@end
