//
//  NSDate+ZCExtension.h
//  bsbdj
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZCExtension)
/**
 *  比较时间差值
 *
 *  @param from <#from description#>
 *
 *  @return <#return value description#>
 */
- (NSDateComponents *)dateFrom:(NSDate *)from;

/**
 *  是否为今天
 */

- (BOOL)isToday;

/**
 *  是否为今年
 */

- (BOOL)isThisYear;
/**
 *  是否为昨天
 */

- (BOOL)isYesterday;
@end
