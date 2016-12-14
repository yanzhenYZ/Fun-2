//
//  YZContentModel.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"

@class YZContentUser;
@class YZContentGroup;
@interface YZContentModel : YZSuperModel
@property (nonatomic, strong) YZContentGroup *group;
@property (nonatomic, strong) NSArray <YZContentUser *> *comments;
@end
