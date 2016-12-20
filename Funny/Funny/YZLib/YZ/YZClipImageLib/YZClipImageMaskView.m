//
//  YZClipImageMaskView.m
//  test
//
//  Created by yanzhen on 16/12/20.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZClipImageMaskView.h"

@interface YZClipImageMaskView ()
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@end

@implementation YZClipImageMaskView

- (instancetype)initWithFrame:(CGRect)frame clipFrame:(CGRect)clipFrame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self createMaskLayer:clipFrame];
        UIView *view = [[UIView alloc] initWithFrame:clipFrame];
        view.backgroundColor = [UIColor clearColor];
        view.layer.borderWidth = 1.0;
        view.layer.borderColor = FunnyColor.CGColor;
        [self addSubview:view];
    }
    return self;
}

- (void)createMaskLayer:(CGRect)clipFrame{
    _maskLayer = [self creatMaskLayerWithExceptRect:clipFrame];
    _maskLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    [self.layer addSublayer:_maskLayer];
}

- (CAShapeLayer *)creatMaskLayerWithExceptRect:(CGRect)exceptRect{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    CGFloat exceptX = exceptRect.origin.x;
    CGFloat exceptY = exceptRect.origin.y;
    CGFloat exceptW = exceptRect.size.width;
    CGFloat exceptH = exceptRect.size.height;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.width, exceptY)];
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, exceptY, exceptX, exceptH)]];
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, exceptY + exceptH, self.width, exceptY)]];
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(exceptX + exceptW, exceptY, exceptX, exceptH)]];
    layer.path = path.CGPath;
    return layer;
}

@end
