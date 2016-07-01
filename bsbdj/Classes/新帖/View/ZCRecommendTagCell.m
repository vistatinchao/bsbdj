//
//  ZCRecommendTagCell.m
//  bsbdj
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCRecommendTagCell.h"
#import "ZCRecommendTag.h"

@interface ZCRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end
@implementation ZCRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setRecommendTag:(ZCRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    NSString *subNumber = nil;
    if (recommendTag.sub_number>=10000)
    {
        subNumber = [NSString stringWithFormat:@"%.1f万人关注",recommendTag.sub_number/10000.0];
    }
    else
    {
        subNumber = [NSString stringWithFormat:@"%zd人关注",recommendTag.sub_number];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width-=2*frame.origin.x;
    frame.size.height-=1;
    [super setFrame:frame];
}

@end
