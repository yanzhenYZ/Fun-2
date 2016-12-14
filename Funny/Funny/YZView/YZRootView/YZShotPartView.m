//
//  YZShotPartView.m
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZShotPartView.h"

@interface YZShotPartView ()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGRect shotRect;
@end
@implementation YZShotPartView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor yellowColor];
        self.clipsToBounds = YES;
        [self prepareShapeLayer];
        UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
        
        void (^block)(UIView *view) = ^(UIView *view){
            [view corner];
            view.layer.borderWidth = 1.0;
            view.layer.borderColor = FunnyColor.CGColor;
            view.backgroundColor = [UIColor clearColor];
        };
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnWH = 30.0;
        CGFloat btnY = self.height - btnWH - 10;
        cancelBtn.frame = CGRectMake(self.width - 40, btnY, btnWH, btnWH);
        block(cancelBtn);
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"closeWindowView"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(self.width - 80, btnY, btnWH, btnWH);
        block(sureBtn);
        [sureBtn setTitle:@"OK" forState:UIControlStateNormal];
        [sureBtn setTitleColor:FunnyColor forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
    }
    return self;
}

- (void)cancelBtnClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(shotPart:frme:)]) {
        [_delegate shotPart:NO frme:CGRectZero];
    }
}

- (void)sureBtnClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(shotPart:frme:)]) {
        [_delegate shotPart:YES frme:self.shotRect];
    }
}

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    static CGPoint startPoint;
    
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        self.shapeLayer.path = NULL;
        
        startPoint = [pan locationInView:self];
        if (startPoint.x<=20) {
            startPoint.x=1.0f;
        }
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint currentPoint = [pan locationInView:self];
        CGPathRef path = CGPathCreateWithRect(CGRectMake(startPoint.x, startPoint.y, currentPoint.x - startPoint.x, currentPoint.y - startPoint.y), NULL);
        self.shotRect = CGRectMake(startPoint.x, startPoint.y, currentPoint.x - startPoint.x, currentPoint.y - startPoint.y);
        self.shapeLayer.path = path;
        CGPathRelease(path);
    }
    
}


- (void)prepareShapeLayer
{
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.lineWidth   = 2;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapeLayer.fillColor   = [[UIColor grayColor] colorWithAlphaComponent:0.15f].CGColor;
    self.shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:5], nil];
    
    CGPathRef path = CGPathCreateWithRect(CGRectInset(self.bounds, 20, 150), NULL);
    self.shotRect = CGRectInset(self.bounds, 20, 150);
    self.shapeLayer.path = path;
    CGPathRelease(path);
    [self.layer addSublayer:self.shapeLayer];
}
@end
