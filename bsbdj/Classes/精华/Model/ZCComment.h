//
//  ZCComment.h
//  bsbdj
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCUser;
@interface ZCComment : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *voiceuri;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) NSInteger voicetime;
@property (nonatomic,assign) NSInteger like_count;
@property (nonatomic,strong) ZCUser *user;
@end
