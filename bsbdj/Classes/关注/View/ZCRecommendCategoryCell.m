//
//  ZCRecommendCategoryCell.m
//  bsbdj
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCRecommendCategoryCell.h"
#import "ZCRecommendCategory.h"
@interface ZCRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *indicateView;

@end
@implementation ZCRecommendCategoryCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = ZCRGBColor(244, 244, 244);
    self.indicateView.backgroundColor = ZCRGBColor(219, 21, 26);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.indicateView.hidden = !selected;
    self.textLabel.textColor = selected?self.indicateView.backgroundColor:ZCRGBColor(78, 78, 78);
}

- (void)setCategory:(ZCRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height-2*self.textLabel.y;
}
@end
