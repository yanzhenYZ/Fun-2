//
//  YZGeneralEnum.h
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#ifndef YZGeneralEnum_h
#define YZGeneralEnum_h

typedef NS_ENUM(NSUInteger, YZAPPNAME) {
    YZAPPNAME_CONTENT = 100,
    YZAPPNAME_GIFSHOW,
    YZAPPNAME_BUDEJIE,
    YZAPPNAME_WALFARE,
    YZAPPNAME_UC,
    YZAPPNAME_NETEASE,
    YZAPPNAME_YINGKE,
    YZAPPNAME_DRAWPICTURE,
    YZAPPNAME_NOTE,
    YZAPPNAME_QR
};
//YZYKTabBarViewController
static NSString *YZApp[] = {
    [YZAPPNAME_CONTENT]      = @"YZContentTabBarViewController",
    [YZAPPNAME_GIFSHOW]      = @"YZGifshowTabBarViewController",
    [YZAPPNAME_BUDEJIE]      = @"YZBuDeJieTabBarViewController",
    [YZAPPNAME_WALFARE]      = @"YZWalfareTabBarViewController",
    [YZAPPNAME_UC]           = @"YZUCTabBarViewController",
    [YZAPPNAME_NETEASE]      = @"YZNetEaseTabBarViewController",
    [YZAPPNAME_YINGKE]       = @"YZYKTabBarViewController",
    [YZAPPNAME_DRAWPICTURE]  = @"YZDrawPictureViewController",
    [YZAPPNAME_NOTE]         = @"YZNoteLockedViewController",
    [YZAPPNAME_QR]           = @"YZQRViewController",
};

//上拉，下拉
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshType_PULL   = -1,
    RefreshType_NORMAL = 0,
    RefreshType_PUSH
};
#endif /* YZGeneralEnum_h */
