//
//  YZWalfareVideoFrame.h
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZVideoFrame.h"

@class YZWalfareVideoModel;
@interface YZWalfareVideoFrame : YZVideoFrame

@property (nonatomic, strong) YZWalfareVideoModel *videoModel;
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;
@end

#pragma mark - YZWalfareVideoModel
@interface YZWalfareVideoModel : YZSuperModel
/**             发布时间                 */
@property (nonatomic, copy) NSString *update_time;
/**             发布内容                 */
@property (nonatomic, copy) NSString *wbody;
/**             图片地址                 */
@property (nonatomic, copy) NSString *vpic_small;
/**             播放地址                 */
@property (nonatomic, copy) NSString *vplay_url;
@property (nonatomic, copy) NSString *vsource_url;
@end
