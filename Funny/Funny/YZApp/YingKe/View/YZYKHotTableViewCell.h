//
//  YZYKHotTableViewCell.h
//  yingke
//
//  Created by yanzhen on 16/12/9.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZSLiveModel;
@class YZYingKeModel;
@interface YZYKHotTableViewCell : UITableViewCell

- (void)configureYK:(YZYingKeModel *)model;
- (void)configureSLive:(YZSLiveModel *)model;
@end
