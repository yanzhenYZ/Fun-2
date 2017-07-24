//
//  YZVideoTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperTableViewCell.h"
#import <YZPlayer/YZPlayer.h>

@interface YZVideoTableViewCell : YZSuperTableViewCell
@property (nonatomic, strong, readonly) YZAVView *mainImageView;
@property (nonatomic, strong, readonly) UIButton *playBtn;

@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareURL;
@property (nonatomic) CGRect videoViewFrame;

- (void)tableViewReload;
@end
