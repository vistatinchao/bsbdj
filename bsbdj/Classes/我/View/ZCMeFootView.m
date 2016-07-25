//
//  ZCMeFootView.m
//  bsbdj
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCMeFootView.h"
#import "ZCSquaureButton.h"
#import "ZCSquare.h"
@implementation ZCMeFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self requestData];
    }
    return self;
}

- (void)requestData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        NSArray *squares = [ZCSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        [dic writeToFile:@"/Users/mac/Desktop/zc.doc" atomically:YES];
        [self createSquares:squares];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void)createSquares:(NSArray *)squares
{
    NSInteger maxColes = 4;
    CGFloat buttonW = ZCScreenW/maxColes;
    CGFloat buttonH = buttonW;
    for (NSInteger i=0; i<squares.count; i++) {
        ZCSquaureButton *button = [ZCSquaureButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.square = squares[i];

        NSInteger col = i%maxColes;
        NSInteger row = i/maxColes;
        button.x = col *buttonW;
        button.y = row *buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }

    NSInteger rows = (squares.count + maxColes -1)/maxColes;
    self.height = rows*buttonH;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;

}

- (void)buttonClick:(UIButton *)button
{

}


@end
