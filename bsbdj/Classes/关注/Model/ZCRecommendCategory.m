//
//  ZCRecommendCategory.m
//  bsbdj
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCRecommendCategory.h"

@implementation ZCRecommendCategory
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

- (NSMutableArray *)users
{
    if (!_users)
    {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
