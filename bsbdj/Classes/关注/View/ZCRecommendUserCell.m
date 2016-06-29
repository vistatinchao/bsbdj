//
//  ZCRecommendUserCell.m
//  bsbdj
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCRecommendUserCell.h"
#import "ZCRecommendUser.h"
@interface ZCRecommendUserCell()

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *careBtn;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end
@implementation ZCRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(ZCRecommendUser *)user
{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd",user.fans_count];
   [self.headImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
