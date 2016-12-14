//
//  YZGifshowModel.h
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"

@interface YZGifshowModel : YZSuperModel
//头像 时间 昵称 图片 视频地址
@property (nonatomic, copy) NSString *headurl;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *user_name;
@property (copy, nonatomic) NSString *thumbnail_url;
@property (copy, nonatomic) NSString *main_mv_url;
@end
