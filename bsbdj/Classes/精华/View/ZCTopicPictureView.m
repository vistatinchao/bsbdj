//
//  ZCTopicPictureView.m
//  bsbdj
//
//  Created by mac on 16/7/12.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTopicPictureView.h"
#import "ZCShowPictureViewController.h"
#import "ZCTopic.h"
#import "ZCProgressView.h"
@interface ZCTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@property (weak, nonatomic) IBOutlet ZCProgressView *progressView;

@end
@implementation ZCTopicPictureView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}

- (IBAction)showPicture
{
    ZCShowPictureViewController *svc = [[ZCShowPictureViewController alloc]init];
    svc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:svc animated:YES completion:nil];
}

- (void)setTopic:(ZCTopic *)topic
{
    _topic = topic;

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topic.picturePregress = 1.0*receivedSize/expectedSize;
        [self.progressView setProgress:topic.picturePregress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        // 如果是大图片，才需要进行绘图处理
        if (topic.isBigPicture==NO) {
            return ;
        }
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width*image.size.height/image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }];

    // 判断gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    self.seeBigButton.hidden = !topic.isBigPicture;
}

+(instancetype)picktureView
{
   return  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:0]lastObject];
}

@end
