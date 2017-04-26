//
//  YZVideoTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperTableViewCell.h"

@class YZVideoTableViewCell;
@protocol VideoPlayDelegate <NSObject>

@optional
- (void)videoPlay:(BOOL)play videoCell:(YZVideoTableViewCell *)videoCell;
/**          暂停和播放状态才能到window播放             */
- (void)playVideoOnWindow:(YZVideoTableViewCell *)cell;
@end

@interface YZVideoTableViewCell : YZSuperTableViewCell
@property (nonatomic, weak) UIImageView *mainImageView;
@property (nonatomic, weak) UIButton *playBtn;
@property (nonatomic, weak) UIProgressView *progressView;

@property (nonatomic, weak) id<VideoPlayDelegate> delegate;

@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareURL;
@property (nonatomic, assign) CGFloat rightSpace;
@property (nonatomic, assign) BOOL isPause;

- (void)tableViewReload;
@end
