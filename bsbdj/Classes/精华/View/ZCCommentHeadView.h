//
//  ZCCommentHeadView.h
//  bsbdj
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCCommentHeadView : UITableViewHeaderFooterView
@property (nonatomic,copy) NSString *title;
+(instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
