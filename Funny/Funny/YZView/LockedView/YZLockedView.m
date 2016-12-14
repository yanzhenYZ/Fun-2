//
//  YZLockedView.m
//  Funny
//
//  Created by yanzhen on 16/12/5.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZLockedView.h"

@interface YZLockedView ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIView *lockView;
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic, strong) NSMutableString *password;
@property (nonatomic, strong) NSMutableArray *views;
@end

@implementation YZLockedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)lockBtnClick:(UIButton *)btn{
    [UIView animateWithDuration:0.05 animations:^{
        [btn setBackgroundColor:YZColor(43, 134, 182)];
    } completion:^(BOOL finished) {
        [btn setBackgroundColor:[UIColor clearColor]];
    }];
    [self addCode:btn.titleLabel.text];
}

- (void)cancelBtnClick:(UIButton *)btn{
    if (self.views.count == 0) return;
    UIView *view = self.views.lastObject;
    view.backgroundColor = [UIColor clearColor];
    [self.views removeLastObject];
    [self.password deleteCharactersInRange:NSMakeRange(self.views.count, 1)];
}

- (void)addCode:(NSString *)code{
    if (self.views.count == 4) return;
    if (self.views.count == 3) {
        UIView *view = [self.topView viewWithTag:103];
        view.backgroundColor = YZColor(43, 134, 182);
        [_password appendString:code];
        [self.views addObject:view];
        if (_block) {
            if (!_block(_password)) {
                [UIView animateWithDuration:0.1 animations:^{
                    self.topView.transform = CGAffineTransformMakeTranslation(20, 0);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        self.topView.transform = CGAffineTransformMakeTranslation(-40, 0);
                    } completion:^(BOOL finished) {
                        self.topView.transform = CGAffineTransformIdentity;
                    }];
                }];
            }
            [self resetAll];
        }
    }else{
        UIView *view = [self.topView viewWithTag:self.views.count + 100];
        view.backgroundColor = YZColor(43, 134, 182);
        [_password appendString:code];
        [self.views addObject:view];
    }
}

- (void)resetAll{
    [self.password deleteCharactersInRange:NSMakeRange(0, self.password.length)];
    [self.views enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = [UIColor clearColor];
    }];
    [self.views removeAllObjects];
}
#pragma mark - UI
- (void)configUI{
    _views = [[NSMutableArray alloc] init];
    _password = [[NSMutableString alloc] init];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"输入密码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17.0];
    titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [self configTopView];
    [self configLockView];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
}

- (void)configTopView{
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < 4; i++) {
        UIView *view = [[UIView alloc] init];
        view.tag = i + 100;
        [self cornerView:view radius:7.5 borderWidth:1 borderColor:YZColor(43, 134, 182)];
        [topView addSubview:view];
    }
    [self addSubview:topView];
    _topView = topView;
}

- (void)configLockView{
    UIView *lockView = [[UIView alloc] init];
    lockView.backgroundColor = [UIColor clearColor];
    CGFloat lockBtnWH = isIpad() ? 80 : 75;
    for (int i = 0; i < 10; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [self cornerView:btn radius:lockBtnWH / 2 borderWidth:2 borderColor:YZColor(43, 134, 182)];
        btn.tag = i;
        if (i == 9) {
            [btn setTitle:@"0" forState:UIControlStateNormal];
        }else{
            [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:27];
        [btn addTarget:self action:@selector(lockBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [lockView addSubview:btn];
    }
    [self addSubview:lockView];
    _lockView = lockView;
}

- (void)cornerView:(UIView *)view radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = radius;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = color.CGColor;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat lockSpace = 25;
    CGFloat lockBtnWH = isIpad() ? 80 : 75;
    CGFloat lockW = lockBtnWH * 3 + lockSpace * 4;
    CGFloat lockH = lockBtnWH * 4 + lockSpace * 5;
    
    //5处于self中心位置，但不在lockView的中心
    _lockView.frame = CGRectMake(0, 0, lockW, lockH);
    _lockView.center = CGPointMake(self.width * 0.5, self.height * 0.5 + (lockBtnWH + lockSpace) * 0.5);
    for (UIButton *btn in _lockView.subviews) {
        NSInteger row = btn.tag / 3;
        NSInteger col = btn.tag % 3;
        if (btn.tag == 9) {
            btn.frame = CGRectMake(0, lockSpace + (lockBtnWH + lockSpace) * row, lockBtnWH, lockBtnWH);
            btn.center = CGPointMake(_lockView.width * 0.5, btn.center.y);
        }else{
            btn.frame = CGRectMake(lockSpace + (lockBtnWH + lockSpace) * col, lockSpace + (lockBtnWH + lockSpace) * row, lockBtnWH, lockBtnWH);
        }
    }
    CGFloat space = 25;
    CGFloat viewWH = 15;
    CGFloat topW = viewWH * 4 + space * 5;
    CGFloat topH = viewWH + 5 * 2;
    _topView.frame = CGRectMake(0, 0, topW, topH);
    _topView.center = CGPointMake(self.width * 0.5, _lockView.y - 30);
    for (UIView *subView in _topView.subviews) {
        subView.frame = CGRectMake(space + (space + viewWH) * (subView.tag - 100), 5, viewWH, viewWH);
    }
    _cancelBtn.frame = CGRectMake(0, 0, lockBtnWH, lockBtnWH);
    _cancelBtn.center = CGPointMake(self.width * 0.5 + lockBtnWH + lockSpace, self.center.y + (lockBtnWH + lockSpace) * 2);
    
    _titleLabel.frame = CGRectMake(0, 0, 150, 25);
    _titleLabel.center = CGPointMake(self.width * 0.5, _topView.y - 25);
}
@end
