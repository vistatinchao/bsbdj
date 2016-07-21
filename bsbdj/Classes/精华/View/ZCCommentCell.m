//
//  ZCCommentCell.m
//  bsbdj
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCCommentCell.h"
#import "ZCComment.h"
#import "ZCUser.h"
@interface ZCCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likecountLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end
@implementation ZCCommentCell


- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setComment:(ZCComment *)comment
{
    _comment = comment;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexView.image = [comment.user.sex isEqualToString:ZCUserSexMale]?[UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.userNameLabel.text = comment.user.username;
    self.likecountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }
    else
    {
        self.voiceButton.hidden = YES;
    }
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = ZCTopicCellMargin;
    frame.size.width -=2*ZCTopicCellMargin;
    [super setFrame:frame];
}

@end
