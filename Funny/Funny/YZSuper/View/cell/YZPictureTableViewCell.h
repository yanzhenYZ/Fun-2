//
//  YZPictureTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperTableViewCell.h"

@interface YZPictureTableViewCell : YZSuperTableViewCell
@property (nonatomic, weak) UIImageView *mainImageView;
@property (nonatomic, assign) BOOL canSave;
@end
