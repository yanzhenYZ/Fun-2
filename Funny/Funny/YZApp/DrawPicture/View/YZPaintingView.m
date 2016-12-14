//
//  YZPaintingView.m
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZPaintingView.h"
#import "YZDPBezierPath.h"

@interface YZPaintingView ()
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) NSMutableArray *paths;
@end

@implementation YZPaintingView

-(void)drawRect:(CGRect)rect
{
    if (!self.paths.count) return;
    for (YZDPBezierPath *path in self.paths) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image=(UIImage *)path;
            [image drawAtPoint:CGPointZero];
        }else{
            [path.color set];
            [path stroke];
        }
    }
    
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _width=2;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point=[touch locationInView:self];
    YZDPBezierPath *path = [YZDPBezierPath initWithLineWidth:_width color:_color startPoint:point];
    
    _path = path;
    [self.paths addObject:path];
    
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point=[touch locationInView:self];
    [_path addLineToPoint:point];
    [self setNeedsDisplay];
    
}
#pragma mark - out
-(void)clearScreen
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}
- (void)undo
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
-(BOOL)isDrawInView
{
    if (_paths.count) {
        return YES;
    }
    return NO;
}
#pragma mark - lazy loading
- (NSMutableArray *)paths
{
    if (!_paths) {
        _paths=[[NSMutableArray alloc] init];
    }
    return _paths;
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    [self.paths addObject:image];
    [self setNeedsDisplay];
}


@end
