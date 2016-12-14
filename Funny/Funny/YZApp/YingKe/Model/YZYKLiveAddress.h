//
//  YZYKLiveAddress.h
//  yingke
//
//  Created by yanzhen on 16/12/13.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZYKLiveAddress : NSObject

+ (void)saveSelfLiveAddress:(NSString *)address;
+ (NSString *)getSelfLiveAddress;
//视频质量
+ (NSUInteger)getVideoQuality;
+ (void)saveVideoQuality:(NSUInteger)quality;
//美颜
+ (CGFloat)getBeautyLevel;
+ (void)saveBeautyLevel:(CGFloat)beautyLevel;

+ (CGFloat)getBrightLevel;
+ (void)saveBrightLevel:(CGFloat)brightLevel;
@end
