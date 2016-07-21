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
#import "ZCTopicVideoView.h"
#import "ZCTopicVoiceView.h"
#import "ZCComment.h"
#import "ZCUser.h"
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
@property (nonatomic,weak)ZCTopicVideoView *videoView;
@property (nonatomic,weak)ZCTopicVoiceView *voiceView;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
@end
@implementation ZCTopicCell

+(instancetype)cell
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (ZCTopicPictureView *)pictureView
{
    if (!_pictureView) {
        ZCTopicPictureView *pictureView = [ZCTopicPictureView picktureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (ZCTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        ZCTopicVoiceView *voiceView = [ZCTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (ZCTopicVideoView *)videoView
{
    if (!_videoView) {
       ZCTopicVideoView *videoView = [ZCTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
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
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    }
    else if (topic.type==ZCTopicTypeVoice)
    {
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
    }
    else if (topic.type==ZCTopicTypeVideo)
    {
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
    }
    else
    {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }

    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@:%@",topic.top_cmt.user.username,topic.top_cmt.content];
    }
    else
    {
        self.topCmtView.hidden = YES;
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

- (IBAction)more:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self.window];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = ZCTopicCellMargin;
    frame.origin.y+=ZCTopicCellMargin;
    frame.size.width -=2*ZCTopicCellMargin;
    frame.size.height=self.topic.cellHight-ZCTopicCellMargin;
    [super setFrame:frame];
}
@end
