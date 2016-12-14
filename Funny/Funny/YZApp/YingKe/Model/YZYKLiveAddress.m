//
//  YZYKLiveAddress.m
//  yingke
//
//  Created by yanzhen on 16/12/13.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKLiveAddress.h"

static NSString *const SELFLIVEADDRESS = @"SelfLiveAddress";
static NSString *const YK_VIDEOQUALITY = @"YK_VideoQuality";
static NSString *const YK_BEAUTYLEVEL = @"YK_BeautyLevel";
static NSString *const YK_BRIGHTLEVEL = @"YK_BrightLevel";
@implementation YZYKLiveAddress

//视频质量
+ (NSUInteger)getVideoQuality{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *videoQuality = [ud objectForKey:YK_VIDEOQUALITY];
    if (videoQuality.unsignedIntegerValue > 0) {
        return videoQuality.unsignedIntegerValue - 100;
    }
    return 5;
}

+ (void)saveVideoQuality:(NSUInteger)quality{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@(quality + 100) forKey:YK_VIDEOQUALITY];
    [ud synchronize];
}
//美颜
+ (CGFloat)getBeautyLevel{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *level = [ud objectForKey:YK_BEAUTYLEVEL];
    return level.floatValue > 0 ? level.floatValue / 10 : 0.5;
}

+ (void)saveBeautyLevel:(CGFloat)beautyLevel{
    //1-10
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@(beautyLevel) forKey:YK_BEAUTYLEVEL];
    [ud synchronize];
}

+ (CGFloat)getBrightLevel{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *level = [ud objectForKey:YK_BRIGHTLEVEL];
    return level.floatValue > 0 ? level.floatValue / 10 : 0.5;
}

+ (void)saveBrightLevel:(CGFloat)brightLevel{
    //1-10
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@(brightLevel) forKey:YK_BRIGHTLEVEL];
    [ud synchronize];
}

+ (void)saveSelfLiveAddress:(NSString *)address{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:address forKey:SELFLIVEADDRESS];
    [ud synchronize];
}

+ (NSString *)getSelfLiveAddress{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *address = [ud objectForKey:SELFLIVEADDRESS];
    if (address.length > 0) {
        return address;
    }
    NSString *footer = [[NSString currentTime] stringByAppendingFormat:@"_%@",[NSUUID UUID]];
    [self saveSelfLiveAddress:footer];
    return footer;
}
@end
