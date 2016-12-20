//
//  YZClipImageViewController.h
//  Funny
//
//  Created by yanzhen on 16/12/20.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZClipImageViewController : UIViewController
//不适用于iPad
- (instancetype)initWithImage:(UIImage *)image clipImage:(void (^)(UIImage *image))block;
@end
