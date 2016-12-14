//
//  YZBuDeJieVideoFrame.h
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZVideoFrame.h"

@class YZBudeJieVideoModel;
@interface YZBuDeJieVideoFrame : YZVideoFrame
@property (nonatomic, strong) YZBudeJieVideoModel *videoModel;
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;
@end

#pragma mark - YZBudeJieVideoModel
@interface YZBudeJieVideoModel : YZSuperModel
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *bimageuri;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *videouri;
@property (nonatomic, copy) NSString *weixin_url;
@end
