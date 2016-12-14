//
//  YZWhatSomeFrame.h
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"
#import "YZWhatSomeGroup.h"

@class YZWhatSomeModel;
@interface YZWhatSomeFrame : YZSuperFrame
@property (nonatomic, strong) YZWhatSomeModel *model;
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;
@property (nonatomic, assign, readonly) CGRect mainIVFrame;
@end

#pragma mark - YZWhatSomeModel
@interface YZWhatSomeModel : YZSuperModel
@property (nonatomic, strong) YZWhatSomeGroup *group;
@property (nonatomic, strong) NSArray <YZContentUser *> *comments;
@end
