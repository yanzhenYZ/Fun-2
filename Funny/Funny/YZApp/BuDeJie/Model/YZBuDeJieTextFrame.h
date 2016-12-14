//
//  YZBuDeJieTextFrame.h
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"

@class YZBudeJieTextModel;
@interface YZBuDeJieTextFrame : YZSuperFrame
@property (nonatomic, strong) YZBudeJieTextModel *textModel;
@property (nonatomic, assign, readonly) CGRect mainLabelFrame;
@end
#pragma mark - YZBudeJieTextModel
@interface YZBudeJieTextModel : YZSuperModel
@property (copy, nonatomic) NSString *profile_image;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *create_time;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *weixin_url;
@end
