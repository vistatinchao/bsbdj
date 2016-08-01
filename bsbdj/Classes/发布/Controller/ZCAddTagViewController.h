//
//  ZCAddTagViewController.h
//  bsbdj
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^tagsBlock)(NSArray *tags);
@interface ZCAddTagViewController : UIViewController
/**获取tags的block*/
@property (nonatomic,copy) tagsBlock tagsBlock;

/**所有的标签*/
@property (nonatomic,strong) NSArray *tags;
@end
