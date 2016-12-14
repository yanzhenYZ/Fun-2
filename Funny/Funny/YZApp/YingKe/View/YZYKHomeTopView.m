//
//  YZYKHomeTopView.m
//  yingke
//
//  Created by yanzhen on 16/12/8.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKHomeTopView.h"

@interface YZYKHomeTopView ()
@property (nonatomic, weak) UIButton *hotBtn;
@property (nonatomic, weak) UIButton *nearBtn;
@property (nonatomic, weak) UIImageView *markIV;
@end

@implementation YZYKHomeTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *titles = @[@"热门",@"附近"];
        UIButton *(^btnBlock)(NSInteger tag) = ^(NSInteger tag){
            UIButton *btn = [[UIButton alloc] init];
            CGFloat btnW = self.width / titles.count;
            CGFloat btnX = btnW * (tag - 100);
            btn.frame = CGRectMake(btnX, 0, btnW, self.height);
            [btn setTitle:titles[tag - 100] forState:UIControlStateNormal];
            btn.tag = tag;
            [btn.titleLabel sizeToFit];
            [btn addTarget:self action:@selector(homeTopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            return btn;
        };
        _hotBtn  = btnBlock(HomeTopViewBtnType_Hot);
        _nearBtn = btnBlock(HomeTopViewBtnType_Near);
        UIImageView *markIV = [[UIImageView alloc] init];
//        markIV.image = [UIImage imageNamed:@"topView_down"];
//        markIV.contentMode = UIViewContentModeCenter;
        markIV.frame = CGRectMake(0, 0, _hotBtn.titleLabel.width, 2);
        markIV.center = CGPointMake(_hotBtn.center.x, 36);
        markIV.backgroundColor = [UIColor whiteColor];
        [self addSubview:markIV];
        _markIV = markIV;
    }
    return self;
}

- (void)homeTopBtnClick:(UIButton *)btn{
    NSLog(@"--- %s ---",__func__);
    if ([_delegate respondsToSelector:@selector(homeTopViewClick:)]) {
        [_delegate homeTopViewClick:btn.tag];
    }
    [self scroll:btn.tag];
}

- (void)scroll:(NSInteger)tag{
    UIButton *btn = (UIButton *)[self viewWithTag:tag];
    [UIView animateWithDuration:0.15 animations:^{
        _markIV.centerX = btn.centerX;
    }];
}
@end
