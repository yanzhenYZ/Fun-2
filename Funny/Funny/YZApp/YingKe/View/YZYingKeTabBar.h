//
//  YZYingKeTabBar.h
//  yingke
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, YKTabBarBtnType) {
    YKTabBarBtnType_Home = 100,
    YKTabBarBtnType_My,
    YKTabBarBtnType_Launch
};

@protocol YZYingKeTabBarDelegate <NSObject>

- (void)yingkeTabBarButtonClick:(YKTabBarBtnType)type;

@end

@interface YZYingKeTabBar : UIView
@property (nonatomic, weak) id<YZYingKeTabBarDelegate> delegate;

@end
