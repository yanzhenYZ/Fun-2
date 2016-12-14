//
//  YZDPBezierPath.m
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZDPBezierPath.h"

@implementation YZDPBezierPath
+ (instancetype)initWithLineWidth:(CGFloat)width color:(UIColor *)color startPoint:(CGPoint)startPoint{
    YZDPBezierPath *path = [YZDPBezierPath bezierPath];
    path.lineWidth = width;
    path.color = color;
    [path moveToPoint:startPoint];
    return path;
}
@end
