//
//  YZPaintingImageView.m
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZPaintingImageView.h"

@implementation YZPaintingImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        [self addGesture];
    }
    return self;
}

- (void)drawInPictureStart{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            // 1.截屏
            UIImage *newImage = [UIImage imageWithCaptureView:self];
            // 2.把图片传给控制器
            _block(newImage);
            // 3.把自己移除父控件
            [self removeFromSuperview];
        }];
    }];
}

#pragma mark - gesture
- (void)addGesture{
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
    pin.delegate = self;
    [self addGestureRecognizer:pin];
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    [self addGestureRecognizer:rotation];
}

- (void)pinAction:(UIPinchGestureRecognizer *)pin
{
    self.transform = CGAffineTransformScale(self.transform, pin.scale, pin.scale);
    pin.scale = 1;
}

- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    self.transform = CGAffineTransformRotate(self.transform, rotation.rotation);
    // 复位
    rotation.rotation = 0;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
