//
//  YZYingKeModel.h
//  yingke
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YZYingKeCreator;
@interface YZYingKeModel : NSObject
/**           所在城市               */
@property (nonatomic, copy) NSString *city;
/**           直播创建人             */
@property (nonatomic, strong) YZYingKeCreator *creator;
/**           附近的人--距离         */
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, assign) NSInteger group;
/**           id                   */
@property (nonatomic, copy) NSString *ID;
/**           在线人数               */
@property (nonatomic, assign) long online_users;
/**           直播间id               */
@property (nonatomic, assign) NSInteger room_id;
/**           分享地址？？            */
@property (nonatomic, copy) NSString *share_addr;
/**           视频流地址              */
@property (nonatomic, copy) NSString *stream_addr;
@property (nonatomic, assign, getter=isShow) BOOL show;

@end

#pragma mark - YZYingKeCreator
@interface YZYingKeCreator : NSObject
/**           id                   */
//@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *ID;
/**           等级                  */
@property (nonatomic, strong) NSNumber *level;
/**           昵称                  */
@property (nonatomic, copy) NSString *nick;
/**           图片地址               */
@property (nonatomic, copy) NSString *portrait;

///**           生日                  */
//@property (nonatomic, copy) NSString *birth;
///**           感情状态               */
//@property (nonatomic, copy) NSString *emotion;
///**           家乡                  */
//@property (nonatomic, copy) NSString *hometown;
///**           位置                  */
//@property (nonatomic, copy) NSString *location;
///**           职业                  */
//@property (nonatomic, copy) NSString *profession;
///**           排行？？               */
//@property (nonatomic, strong) NSNumber *rank_veri;
///**           性别0=女               */
//@property (nonatomic, strong) NSNumber *sex;
//@property (nonatomic, strong) NSString * thirdPlatform;
//@property (nonatomic, strong) NSString * veriInfo;
@end
