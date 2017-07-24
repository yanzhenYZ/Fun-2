//
//  YZPaintingView.m
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZPaintingView.h"
#import "YZDPBezierPath.h"
//性能优化
//http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==&mid=447105405&idx=1&sn=054dc54289a98e8a39f2b9386f4f620e&scene=0#wechat_redirect

@interface YZPaintingView ()
@property (nonatomic, strong) YZDPBezierPath *path;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSMutableArray *layers;
@end

@implementation YZPaintingView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _color = [UIColor blackColor];
    _width = 2;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    YZDPBezierPath *path = [YZDPBezierPath initWithLineWidth:_width color:_color startPoint:point];
    _path = path;
    
    CAShapeLayer *slayer = [CAShapeLayer layer];
    slayer.path = path.CGPath;
    slayer.backgroundColor = [UIColor clearColor].CGColor;
    slayer.fillColor = [UIColor clearColor].CGColor;
    slayer.lineCap = kCALineCapRound;
    slayer.lineJoin = kCALineJoinRound;
    slayer.strokeColor = path.color.CGColor;
    slayer.lineWidth = path.lineWidth;
    [self.layer addSublayer:slayer];
    _shapeLayer = slayer;
    [self.layers addObject:slayer];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [_path addLineToPoint:point];
    _shapeLayer.path = _path.CGPath;
    
}
#pragma mark - out
-(NSMutableArray *)layers
{
    if (!_layers) {
        _layers = [[NSMutableArray alloc] init];
    }
    return _layers;
}

-(void)clearScreen
{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layers removeAllObjects];
}

- (void)undo
{
    if (self.layers.count == 0) return;
    [self.layers.lastObject removeFromSuperlayer];
    [self.layers removeLastObject];
}

-(BOOL)isDrawInView
{
    return self.layers.count;
}
#pragma mark - lazy loading
- (void)setImage:(UIImage *)image
{
    CALayer *layer = [CALayer layer];
    layer.contents = (__bridge id _Nullable)(image.CGImage);
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    [self.layers addObject:layer];
}


@end
