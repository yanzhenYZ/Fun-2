//
//  YZWalfareTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfareTabBarViewController.h"
#import "YZWalfareViewController.h"
#import "WalfareMacro.h"
#import "YZNVCModel.h"

@interface YZWalfareTabBarViewController ()

@end

@implementation YZWalfareTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *(^nvcBlock)(YZNVCModel *model) = ^(YZNVCModel *model){
        YZWalfareViewController *vc = [[NSClassFromString(model.vcName) alloc] init];
        vc.defaultURL  = model.strings[0];
        vc.pullHeadURL = model.strings[1];
        vc.pushHeadURL = model.strings[2];
        UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:vc];
        vc.title = model.title;
        NSString *uImageName = [model.imageHeader stringByAppendingString:@"_u"];
        NSString *sImageName = [model.imageHeader stringByAppendingString:@"_s"];
        UIImage *unSelectImage = [UIImage imageNamedWithTabBar:uImageName];
        UIImage *selectImage = [UIImage imageNamedWithTabBar:sImageName];
        [nvc.tabBarItem setImage:unSelectImage];
        [nvc.tabBarItem setSelectedImage:selectImage];
        return nvc;
    };
    YZNVCModel *model = [[YZNVCModel alloc] init];
    model.vcName = @"YZWalfareVideoViewController";
    model.title = @"视频";
    model.imageHeader = @"weibo_music";
    model.strings = @[WalfareVideoDefaultURL,WalfareVideoPullHeadURL,WalfareVideoPushHeadURL];
    UINavigationController *nvc1 = nvcBlock(model);
    
    model.vcName = @"YZWalfareTextViewController";
    model.title = @"段子";
    model.imageHeader = @"weibo_compose";
    model.strings = @[WalfareTextDefaultURL,WalfareTextPullHeadURL,WalfareTextPushHeadURL];
    UINavigationController *nvc2 = nvcBlock(model);
    
    model.vcName = @"YZWalfareGirlViewController";
    model.title = @"美女";
    model.imageHeader = @"weibo_favorite";
    model.strings = @[WalfareGirlDefaultURL,WalfareGirlPullHeadURL,WalfareGirlPushHeadURL];
    UINavigationController *nvc3 = nvcBlock(model);
    self.viewControllers = @[nvc1,nvc2,nvc3];
}



@end
