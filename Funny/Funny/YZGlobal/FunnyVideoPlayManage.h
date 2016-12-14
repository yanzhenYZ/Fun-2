//
//  FunnyVideoPlayManage.h
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CMTime.h>

@class YZVideoTableViewCell;
@interface FunnyVideoPlayManage : NSObject
HShareInstance(VideoManage);

@property (nonatomic, readonly) CMTime currentTime;

- (void)playVideoWithCell:(YZVideoTableViewCell *)cell urlString:(NSString *)urlString play:(BOOL)play;
- (void)tableViewReload;
@end
