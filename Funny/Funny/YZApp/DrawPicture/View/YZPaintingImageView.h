//
//  YZPaintingImageView.h
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendImageBlock)(UIImage *image);
@interface YZPaintingImageView : UIImageView<UIGestureRecognizerDelegate>
@property (copy, nonatomic) SendImageBlock block;
- (void)drawInPictureStart;
@end
