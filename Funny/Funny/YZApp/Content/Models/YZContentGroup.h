//
//  YZContentGroup.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"
#import "YZContentUser.h"

@class YZContentLarge_cover;
@class YZContent720p_video;
@interface YZContentGroup : YZSuperFrame
//发表用户不包含text
@property (nonatomic, strong) YZContentUser *user;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, strong) NSNumber *create_time;
@property (nonatomic, assign) NSNumber *duration;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *mp4_url;
/**              资源名称            */
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, strong) YZContentLarge_cover *large_cover;
//参考MJExtensionConfig.h
@property (nonatomic, strong) YZContent720p_video *video_720p;
@end

#pragma mark - YZContentLarge_cover
@interface YZContentLarge_cover : NSObject
//没用
@property (nonatomic, copy) NSString *uri;
//视频图像---[0][url]
@property (nonatomic, strong) NSArray <NSDictionary *>*url_list;
@end
#pragma mark - YZContent720p_video
@interface YZContent720p_video : NSObject
//360p_video 480p_video (720p_video) origin_video
/**           视频宽              */
@property (nonatomic, strong) NSNumber *width;
/**           视频高              */
@property (nonatomic, strong) NSNumber *height;
//视频图像---[0][url]
/**           视频地址              */
@property (nonatomic, strong) NSArray <NSDictionary *>*url_list;
@end
