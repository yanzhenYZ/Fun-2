//
//  YZWalfareGirlFrame.h
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"

@class YZWalfareGirlModel;
@interface YZWalfareGirlFrame : YZSuperFrame
@property (nonatomic, strong) YZWalfareGirlModel *girlModel;
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;
@property (nonatomic, assign, readonly) CGRect mainIVFrame;
@end

#pragma mark - YZWalfareGirlModel
@interface YZWalfareGirlModel : YZSuperModel
/**             发布时间                 */
@property (nonatomic, copy) NSString *update_time;
/**             发布内容                 */
@property (nonatomic, copy) NSString *wbody;
/**             图片高度                 */
@property (nonatomic, copy) NSString *wpic_m_height;
/**             图片宽度                 */
@property (nonatomic, copy) NSString *wpic_m_width;
/**             图片地址                 */
@property (nonatomic, copy) NSString *wpic_middle;
/**             是否是gif                */
@property (nonatomic, copy) NSString *is_gif;
@end
