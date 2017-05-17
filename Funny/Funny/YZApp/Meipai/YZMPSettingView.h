//
//  YZMPSettingView.h
//  Funny
//
//  Created by yanzhen on 2017/5/9.
//  Copyright © 2017年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZMPSettingViewDelegate <NSObject>

- (void)beautyValueChanged:(CGFloat)value;
- (void)brightValueChanged:(CGFloat)value;

@end

@interface YZMPSettingView : UIView
@property (nonatomic, weak) id<YZMPSettingViewDelegate>delegate;
@end
