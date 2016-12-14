//
//  YZGifshowTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZGifshowTabBarViewController.h"
#import "YZGifshowViewController.h"
#import "YZWhatSomeViewController.h"
#import "GifShowMacro.h"

@interface YZGifshowTabBarViewController ()

@end

@implementation YZGifshowTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    YZGifshowViewController *vc1 = [[YZGifshowViewController alloc] init];
    vc1.title = @"快手";
    UINavigationController *nvc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UIImage *unSelectImage = [UIImage imageNamedWithTabBar:@"weibo_music_u"];
    UIImage *selectImage = [UIImage imageNamedWithTabBar:@"weibo_music_s"];
    [nvc1.tabBarItem setImage:unSelectImage];
    [nvc1.tabBarItem setSelectedImage:selectImage];
    
    YZWhatSomeViewController *vc2 = [[YZWhatSomeViewController alloc] init];
    vc2.title = @"图片";
    vc2.pullHeaderStr = SomeWhatPullHeadURL;
    vc2.pullFooterStr = SomeWhatDefaultFootURL;
    vc2.pushHeaderStr = SomeWhatPushHeadURL;
    vc2.pushFooterStr = SomeWhatDefaultFootURL;
    UINavigationController *nvc2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    unSelectImage = [UIImage imageNamedWithTabBar:@"weibo_favorite_u"];
    selectImage = [UIImage imageNamedWithTabBar:@"weibo_favorite_s"];
    [nvc2.tabBarItem setImage:unSelectImage];
    [nvc2.tabBarItem setSelectedImage:selectImage];
    self.viewControllers = @[nvc1,nvc2];
}



@end
