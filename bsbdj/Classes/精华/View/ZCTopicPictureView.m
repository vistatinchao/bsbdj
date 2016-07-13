//
//  ZCTopicPictureView.m
//  bsbdj
//
//  Created by mac on 16/7/12.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTopicPictureView.h"
#import "ZCTopic.h"
@interface ZCTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;


@end
@implementation ZCTopicPictureView

- (void)setTopic:(ZCTopic *)topic
{
    _topic = topic;
    ZCLog(@"%@",self.imageView);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        <#code#>
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        <#code#>
//    }];

    // 判断gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    self.seeBigButton.hidden = !topic.isBigPicture;
}


@end
