//
//  YZDPBezierPath.h
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZDPBezierPath : UIBezierPath
@property (nonatomic, strong) UIColor *color;
+ (instancetype)initWithLineWidth:(CGFloat)width color:(UIColor *)color startPoint:(CGPoint)startPoint;
@end
