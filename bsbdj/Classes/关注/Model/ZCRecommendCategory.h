//
//  ZCRecommendCategory.h
//  bsbdj
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRecommendCategory : NSObject
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign)NSInteger count;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end
