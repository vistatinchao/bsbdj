//
//  ZCVoiceViewController.m
//  bsbdj
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCVoiceViewController.h"

@interface ZCVoiceViewController ()

@end

@implementation ZCVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    }
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor blueColor];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd", [self class], indexPath.row];

    return cell;
}
@end
