//
//  YZWalfareTextFrame.h
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"

@class YZWalfareTextModel;
@interface YZWalfareTextFrame : YZSuperFrame
@property (nonatomic, strong) YZWalfareTextModel *textModel;
@property (nonatomic, assign, readonly) CGRect mainLabelFrame;
@end

#pragma mark - YZWalfareTextModel
@interface YZWalfareTextModel : YZSuperModel
/**             发布时间                 */
@property (copy, nonatomic) NSString *update_time;
/**             发布内容                 */
@property (copy, nonatomic) NSString *wbody;
@end
