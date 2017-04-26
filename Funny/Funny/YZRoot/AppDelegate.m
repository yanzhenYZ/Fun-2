//
//  AppDelegate.m
//  Funny
//
//  Created by yanzhen on 16/11/24.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "AppDelegate.h"
#import "YZRootViewController.h"
#import "VideoWindow.h"
#import "MBProgressHUD+YZZ.h"
#import "AFNetworking.h"
#import "WXApi.h"
#import <AudioToolbox/AudioServices.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

void FunnyUncaughtExceptionHandler(NSException *exception){
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [document stringByAppendingPathComponent:@"FunnyCrash.log"];
    //时间
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [format stringFromDate:[NSDate date]];
    dateString = [NSString stringWithFormat:@"Crash time  :*** -%@",dateString];
    [dateString writeLogToFile:path];
    //崩溃的名称
    NSString *crashName = [NSString stringWithFormat:@"Crash name  :*** -%@",exception.name];
    [crashName writeLogToFile:path];
    //崩溃的原因
    NSString *crashReason = [NSString stringWithFormat:@"Crash reason:%@",exception.reason];
    [crashReason writeLogToFile:path];
    //崩溃的详情信息
    [@"Crash info:" writeLogToFile:path];
    [exception.callStackSymbols enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj writeLogToFile:path];
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self monitoringNetwork];
    [self configVideoWindow];
    [self config3DTouch];
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:FunnyColor}];
    [navigationBar setTintColor:FunnyColor];
    NSSetUncaughtExceptionHandler(&FunnyUncaughtExceptionHandler);
    [WXApi registerApp:@"wx188b02f35eb50c9c"];
    return YES;
}

- (void)config3DTouch{
    UIApplicationShortcutItem *(^itemBlock)(NSString *type,NSString *title,UIApplicationShortcutIcon *icon) = ^(NSString *type,NSString *title,UIApplicationShortcutIcon *icon){
        UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:type localizedTitle:title localizedSubtitle:nil icon:icon userInfo:nil];
        return item;
    };
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCaptureVideo];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShuffle];
    NSArray *items = @[itemBlock(@"106",@"直播",icon2),itemBlock(@"100",@"内涵段子",icon1),itemBlock(@"1002",@"扫一扫",icon3)];
    [UIApplication sharedApplication].shortcutItems = items;
}

- (void)configVideoWindow{
    //初始化该window之后，不要使用[[UIApplication sharedApplication] windows].lastObject
    self.videoWindow = [[VideoWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.videoWindow.backgroundColor = [UIColor clearColor];
    self.videoWindow.windowLevel = UIWindowLevelAlert + 1;
}

- (void)monitoringNetwork{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    YZWeakSelf(self)
    //在检测网络之前，必须[[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserverForName:AFNetworkingReachabilityDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusReachableViaWiFi) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            MBProgressHUD *hud = [MBProgressHUD showMessage:@"WIFI中断,请退出程序" toView:weakself.window];
            hud.labelColor = [UIColor redColor];
            [hud hide:YES afterDelay:2.0f];
        }
    }];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([url.scheme isEqualToString:@"BCYZ"]) {
        NSArray *subString = [url.absoluteString componentsSeparatedByString:@"//"];
        NSString *tagString = subString[1];
        [self widgetIntoVC:tagString.integerValue];
    }
    return YES;
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    [self widgetIntoVC:shortcutItem.type.integerValue];
}

- (void)widgetIntoVC:(NSInteger)tag{
    UINavigationController *rootNVC = (UINavigationController *)self.window.rootViewController;
    YZRootViewController *rootVC = rootNVC.viewControllers.firstObject;
    [rootVC widgetIntoViewController:tag];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [GlobalManager clearCache:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
