//
//  AppDelegate.h
//  Funny
//
//  Created by yanzhen on 16/11/24.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YZPlayer/YZPlayer.h>

#define SharedAppDelegate (AppDelegate*)([UIApplication sharedApplication].delegate)

@class VideoWindow;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) YZAVWindow *avWindow;

@end

