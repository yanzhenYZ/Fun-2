//
//  YZYKHomeTopView.h
//  yingke
//
//  Created by yanzhen on 16/12/8.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HomeTopViewBtnType) {
    HomeTopViewBtnType_Hot = 100,
    HomeTopViewBtnType_Near
};

@protocol YZYKHomeTopViewDelegate <NSObject>

- (void)homeTopViewClick:(HomeTopViewBtnType)type;

@end

@interface YZYKHomeTopView : UIView
@property (nonatomic, weak) id<YZYKHomeTopViewDelegate> delegate;

- (void)scroll:(NSInteger)tag;

@end
