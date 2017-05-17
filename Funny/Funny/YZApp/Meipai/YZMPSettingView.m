//
//  YZMPSettingView.m
//  Funny
//
//  Created by yanzhen on 2017/5/9.
//  Copyright © 2017年 v2tech. All rights reserved.
//

#import "YZMPSettingView.h"

@interface YZMPSettingView ()
@property (nonatomic, strong) UISlider *beautyLevel;
@property (nonatomic, strong) UISlider *brightLevel;
@end

@implementation YZMPSettingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        [self addSubview:effectView];
        
        _beautyLevel = [[UISlider alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, 30)];
        _beautyLevel.value = 0.5;
        [_beautyLevel setMinimumTrackImage:[UIImage imageNamed:@"mp_slider_background"] forState:UIControlStateNormal];
        [_beautyLevel addTarget:self action:@selector(beautyLevelValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_beautyLevel];
        
        _brightLevel = [[UISlider alloc] initWithFrame:CGRectMake(0, 60, frame.size.width, 30)];
        [_brightLevel setMinimumTrackImage:[UIImage imageNamed:@"mp_slider_background"] forState:UIControlStateNormal];
        _brightLevel.value = 0.5;
        [_brightLevel addTarget:self action:@selector(brightLevelValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_brightLevel];
    }
    return self;
}

- (void)beautyLevelValueChanged:(UISlider *)slider
{
    if ([_delegate respondsToSelector:@selector(beautyValueChanged:)]) {
        [_delegate beautyValueChanged:slider.value];
    }
}

- (void)brightLevelValueChanged:(UISlider *)slider
{
    if ([_delegate respondsToSelector:@selector(brightValueChanged:)]) {
        [_delegate brightValueChanged:slider.value];
    }
}
@end
