//
//  YZContentTextFrame.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"
#import "YZContentGroup.h"
#import "YZContentMacro.h"
#import "YZContentModel.h"

@interface YZContentTextFrame : YZSuperFrame
@property (nonatomic, strong) YZContentModel *contentModel;
@property (nonatomic, assign, readonly) CGRect mainLabelFrame;
@property (nonatomic, assign, readonly) CGRect commentViewFrame;
@end
