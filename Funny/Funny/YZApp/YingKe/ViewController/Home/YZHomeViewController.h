//
//  YZHomeViewController.h
//  yingke
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperSecondViewController.h"

@interface YZHomeViewController : YZSuperSecondViewController

- (void)childVCDidScroll:(CGFloat)offsetY isHot:(BOOL)hot;
- (void)childVCDidEndDragging:(CGFloat)offsetY;
- (void)push;
@end
