//
//  ZCTagTextField.h
//  bsbdj
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^deleteBlock)();
@interface ZCTagTextField : UITextField
@property (nonatomic,copy) deleteBlock deleteBlock;
@end
