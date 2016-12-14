//
//  YZYingKeTabBar.m
//  yingke
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYingKeTabBar.h"

@interface YZYingKeTabBar ()
@property (nonatomic, weak) UIButton *homeBtn;
@property (nonatomic, weak) UIButton *myBtn;
@property (nonatomic, weak) UIButton *cameraBtn;
@property (nonatomic, strong) UIButton *selectedBtn;
@end

@implementation YZYingKeTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *(^btnBlock)(NSInteger tag,NSString *imageName) = ^(NSInteger tag,NSString *imageName){
            UIButton *btn = [[UIButton alloc] init];
            btn.adjustsImageWhenHighlighted = NO;
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            NSString *selectedImageName = [imageName stringByAppendingString:@"_p"];
            [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
            btn.tag = tag;
            [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            return btn;
        };
        _myBtn   = btnBlock(YKTabBarBtnType_My,@"tab_me");
        _homeBtn = btnBlock(YKTabBarBtnType_Home,@"tab_live");
        _homeBtn.selected = YES;
        _selectedBtn = _homeBtn;
        
        UIButton *cameraBtn = [[UIButton alloc] init];
        [cameraBtn setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [cameraBtn sizeToFit];
        [cameraBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cameraBtn.tag = YKTabBarBtnType_Launch;
        [self addSubview:cameraBtn];
        _cameraBtn = cameraBtn;
    }
    return self;
}

- (void)itemBtnClick:(UIButton *)btn{
    //
    if (self.selectedBtn == btn) return;
    if ([_delegate respondsToSelector:@selector(yingkeTabBarButtonClick:)]) {
        [_delegate yingkeTabBarButtonClick:btn.tag];
    }
    if (btn.tag == YKTabBarBtnType_Launch) return;
    
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    [UIView animateWithDuration:0.2 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.25, 1.25);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform = CGAffineTransformIdentity;
        }];
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //87
    self.cameraBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5 - 20);
    //(87/2 - (self.height * 0.5 - 20) + 49) = 88(tabBar最高)
    self.homeBtn.frame = CGRectMake(0, 0, self.width * 0.5, self.height);
    self.myBtn.frame = CGRectMake(self.width * 0.5, 0, self.width * 0.5, self.height);
}
@end
