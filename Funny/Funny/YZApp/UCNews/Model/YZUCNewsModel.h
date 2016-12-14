//
//  YZUCNewsModel.h
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"

@class YZUCPictureModel;
@interface YZUCNewsModel : YZSuperModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *origin_src_name;
@property (nonatomic, copy) NSString *original_url;
@property (nonatomic, copy) NSNumber *style_type;
@property (nonatomic, copy) NSNumber *publish_time;
//url = 每个图片
@property (nonatomic, strong) NSArray <YZUCPictureModel *>*thumbnails;
@end

#pragma mark - YZUCPictureModel
@interface YZUCPictureModel : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;
@end
