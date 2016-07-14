//
//  ZCTopicCell.m
//  bsbdj
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTopicCell.h"
#import "ZCTopic.h"
#import "ZCTopicPictureView.h"
@interface ZCTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dinbButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sinaView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (nonatomic,weak)ZCTopicPictureView *pictureView;
@end
@implementation ZCTopicCell


- (ZCTopicPictureView *)pictureView
{
    if (!_pictureView) {
        ZCTopicPictureView *pictureView = [ZCTopicPictureView picktureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    self.text_label.numberOfLines = 0;
}

- (void)setTopic:(ZCTopic *)topic
{
    _topic = topic;
    self.sinaView.hidden = !topic.sina_v;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    self.text_label.text = topic.text;
    [self setupButtonTitle:self.dinbButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    if (topic.type == ZCTopicTypePicture) {
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    }
    else if (topic.type==ZCTopicTypeVoice)
    {
        
    }


}

// 设置按钮文字
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeHolder
{
    if (count>10000) {
        placeHolder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }
    else if (count>0)
    {
        placeHolder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeHolder forState:UIControlStateNormal];
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = ZCTopicCellMargin;
    frame.origin.y+=ZCTopicCellMargin;
    frame.size.width -=2*ZCTopicCellMargin;
    frame.size.height-=ZCTopicCellMargin;
    [super setFrame:frame];
}
@end
