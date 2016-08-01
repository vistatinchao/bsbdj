//
//  ZCConst.h
//  bsbdj
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZCTopicTypeAll = 1,
    ZCTopicTypePicture = 10,
    ZCTopicTypeWord = 29,
    ZCTopicTypeVoice = 31,
    ZCTopicTypeVideo = 41,
}ZCTopicType;


UIKIT_EXTERN CGFloat const ZCTitlesViewH;
UIKIT_EXTERN CGFloat const ZCTitlesViewY;
UIKIT_EXTERN CGFloat const ZCTopicCellMargin;
UIKIT_EXTERN CGFloat const ZCTopicCellTextY;
UIKIT_EXTERN CGFloat const ZCTopicCellBottomBarH;

UIKIT_EXTERN CGFloat const ZCTopicCellPictureMaxH;
UIKIT_EXTERN CGFloat const ZCTopicCellPictureBreakH;

UIKIT_EXTERN NSString *const ZCUserSexMale;
UIKIT_EXTERN NSString *const ZCUserSexFemale;

UIKIT_EXTERN CGFloat const ZCTopicCellTopCmtTitleH;

UIKIT_EXTERN NSString *const ZCTabBarDidSelectNotification;
UIKIT_EXTERN NSString *const ZCSelectedControllerIndexKey;
UIKIT_EXTERN NSString *const ZCSelectedControllerKey;

/** 标签-间距 */
UIKIT_EXTERN CGFloat const ZCTagMargin;
UIKIT_EXTERN CGFloat const ZCTagH;