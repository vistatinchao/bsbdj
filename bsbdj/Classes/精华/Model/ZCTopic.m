//
//  ZCTopic.m
//  bsbdj
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTopic.h"

@implementation ZCTopic
{
    CGFloat _cellHight;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"small_image":@"image0",@"middle_image":@"image2",@"large_image":@"image1",@"ID":@"id"};
}

-(NSString *)create_time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:_create_time];
    if (create.isThisYear) {// 今年
        if (create.isToday) {
            NSDateComponents *cmps = [[NSDate date] dateFrom:create];
            if (cmps.hour>=1) {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }
            else if (cmps.minute>=1)
            {
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }
            else
            {
                return @"刚刚";
            }
        }
        else if (create.isYesterday)
        {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        else
        {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }
    else
    {
        return _create_time;
    }

}

- (CGFloat)cellHight
{
    if (!_cellHight) {
        CGSize maxSize = CGSizeMake(ZCScreenW-4*ZCTopicCellMargin, CGFLOAT_MAX);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHight = ZCTopicCellTextY+textH+ZCTopicCellMargin;
        if (self.type==ZCTopicTypePicture) {
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = pictureW*self.height/self.width;
            
            if (pictureH>=ZCTopicCellPictureMaxH) {
                pictureH = ZCTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            CGFloat pictureX = ZCTopicCellMargin;
            CGFloat pictureY = ZCTopicCellMargin+textH+ZCTopicCellTextY;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHight = _cellHight+pictureH+ZCTopicCellMargin;

        }
        else if(self.type==ZCTopicTypeVoice)
        {
            CGFloat voiceX = ZCTopicCellMargin;
            CGFloat voiceY = ZCTopicCellMargin+textH+ZCTopicCellTextY;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW*self.height/self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHight = _cellHight+voiceH+ZCTopicCellMargin;

        }
        else if(self.type == ZCTopicTypeVideo)
        {
            CGFloat videoX = ZCTopicCellMargin;
            CGFloat videoY = ZCTopicCellMargin+textH+ZCTopicCellTextY;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW*self.height/self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHight = _cellHight+videoH+ZCTopicCellMargin;
        }
        _cellHight = _cellHight+ZCTopicCellBottomBarH+ZCTopicCellMargin;
    }
    return _cellHight;
}
@end
