//
//  ZCTopic.h
//  bsbdj
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCTopic : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *profile_image;
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign)NSInteger ding;
@property (nonatomic,assign)NSInteger cai;
@property (nonatomic,assign)NSInteger repost;
@property (nonatomic,assign)NSInteger comment;
@property (nonatomic,assign,getter=isSina_v)BOOL sina_v;
/**
 *  图片宽度
 */
@property (nonatomic,assign) CGFloat width;
/**
 *  图片高度
 */
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,copy) NSString *small_image;
@property (nonatomic,copy) NSString *middle_image;
@property (nonatomic,copy) NSString *large_image;
@property (nonatomic,assign)ZCTopicType type;


/**
 *  辅助属性
 */

@property (nonatomic,assign,readonly)CGFloat cellHight;
@property (nonatomic,assign,readonly)CGRect pictureF;
@property (nonatomic,assign,getter=isBigPicture)BOOL bigPicture;
@property (nonatomic,assign)CGFloat picturePregress;
@end
