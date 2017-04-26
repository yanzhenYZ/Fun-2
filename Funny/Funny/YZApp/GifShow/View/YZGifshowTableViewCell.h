//
//  YZGifshowTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZVideoTableViewCell.h"

@class YZGifshowModel;
@interface YZGifshowTableViewCell : YZVideoTableViewCell
- (void)configure:(YZGifshowModel *)model;
@end
