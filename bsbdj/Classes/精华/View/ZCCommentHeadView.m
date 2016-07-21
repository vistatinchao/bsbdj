//
//  ZCCommentHeadView.m
//  bsbdj
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCCommentHeadView.h"
@interface ZCCommentHeadView()

@property (nonatomic,weak)UILabel *label;
@end
@implementation ZCCommentHeadView


+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    ZCCommentHeadView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header==nil) {
        header = [[self alloc]initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = ZCGlobalBg;
        UILabel *label = [[UILabel alloc]init];
        label.textColor = ZCRGBColor(67, 67, 67);
        label.width = 200;
        label.x = ZCTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text =title;
}
@end
