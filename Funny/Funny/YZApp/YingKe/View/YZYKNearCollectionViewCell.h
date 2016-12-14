//
//  YZYKNearCollectionViewCell.h
//  yingke
//
//  Created by yanzhen on 16/12/9.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZYingKeModel;
@interface YZYKNearCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) YZYingKeModel *model;
- (void)showAnimation;
@end
