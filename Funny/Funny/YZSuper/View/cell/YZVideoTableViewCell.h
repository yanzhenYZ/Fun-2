//
//  YZVideoTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperTableViewCell.h"
#import <YZPlayer/YZPlayer.h>

@class YZVideoTableViewCell;
@protocol VideoPlayDelegate <NSObject>

@optional
/**          暂停和播放状态才能到window播放             */
- (void)playVideoOnWindow:(YZVideoTableViewCell *)cell;
@end

@interface YZVideoTableViewCell : YZSuperTableViewCell
@property (nonatomic, strong, readonly) YZAVView *mainImageView;
@property (nonatomic, strong, readonly) UIButton *playBtn;

//@property (nonatomic, weak) id<VideoPlayDelegate> delegate;

@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareURL;
@property (nonatomic) CGRect videoViewFrame;
@property (nonatomic) CGFloat rightSpace;

- (void)tableViewReload;
@end
