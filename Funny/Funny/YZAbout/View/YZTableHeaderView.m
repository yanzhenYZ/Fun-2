//
//  YZTableHeaderView.m
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZTableHeaderView.h"

@interface YZTableHeaderView ()

@end

@implementation YZTableHeaderView

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

- (void)configUI{
    //外部通过改变frame来变大
    _headImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.clipsToBounds = YES;
    [self addSubview:_headImageView];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGestureAction:)];
    [self addGestureRecognizer:longGesture];
}

- (void)longGestureAction:(UILongPressGestureRecognizer *)longGesture{
    if (longGesture.state == UIGestureRecognizerStateBegan) {
        if ([_delegate respondsToSelector:@selector(touchBeganToChangePhoto)]) {
            [_delegate touchBeganToChangePhoto];
        }
    }
}
@end
