//
//  ZCTopicCell.h
//  bsbdj
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCTopic;
@interface ZCTopicCell : UITableViewCell
@property (nonatomic,strong)ZCTopic *topic;
+(instancetype)cell;
@end
