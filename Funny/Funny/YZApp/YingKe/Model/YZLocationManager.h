//
//  YZLocationManager.h
//  yingke
//
//  Created by yanzhen on 16/12/9.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZLocationManager : NSObject
+ (instancetype)shareManager;
- (void)startUpdatingLocation;
- (void)getLocationCoordinate2D:(void(^)(BOOL locationServicesEnabled,NSString *latitude,NSString *longitude))block;
@end
