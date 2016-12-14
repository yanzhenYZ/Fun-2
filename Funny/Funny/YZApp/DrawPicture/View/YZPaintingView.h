//
//  YZPaintingView.h
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZPaintingView : UIView
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIImage *image;

- (void)clearScreen;
- (void)undo;
- (BOOL)isDrawInView;
@end
