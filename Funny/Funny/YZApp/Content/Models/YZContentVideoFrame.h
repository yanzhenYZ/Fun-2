//
//  YZContentVideoFrame.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZVideoFrame.h"
#import "YZContentGroup.h"
#import "YZContentMacro.h"
#import "YZContentModel.h"

@interface YZContentVideoFrame : YZVideoFrame
@property (nonatomic, strong) YZContentModel *contentModel;
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;
@property (nonatomic, assign, readonly) CGRect commentViewFrame;
@end

