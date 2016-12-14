//
//  MJExtensionConfig.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "YZContentGroup.h"

@implementation MJExtensionConfig
+(void)load{
    [YZContentGroup mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"video_720p" : @"720p_video"
                 };
    }];
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
}
@end
