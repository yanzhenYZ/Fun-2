//
//  YZContentTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZContentTabBarViewController.h"
#import "YZContentViewController.h"
#import "YZNVCModel.h"

@interface YZContentTabBarViewController ()

@end

@implementation YZContentTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *(^nvcBlock)(YZNVCModel *model) = ^(YZNVCModel *model){
        YZContentViewController *vc = [[NSClassFromString(model.vcName) alloc] init];
        vc.pullHeaderStr = model.strings[0];
        vc.pullFooterStr = model.strings[1];
        vc.pushHeaderStr = model.strings[2];
        vc.pushFooterStr = model.strings[3];
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
    model.vcName = @"YZContentRecommendViewController";
    model.title = @"推荐";
    model.imageHeader = @"weibo_home";
    model.strings = @[ContentRecommendMaxHeadURL,ContentRecommendMaxFootURL,ContentRecommendMinHeadURL,ContentRecommendMinFootURL];
    UINavigationController *nvc1 = nvcBlock(model);
    model.vcName = @"YZContentTextViewController";
    model.title = @"段子";
    model.imageHeader = @"weibo_compose";
    model.strings = @[ContextTextHeadURL,ContextTextTailUrl,ConTentTextFooterURL,ContentTextTailerURL];
    UINavigationController *nvc2 = nvcBlock(model);
    model.vcName = @"YZContentVideoViewController";
    model.title = @"视频";
    model.imageHeader = @"weibo_music";
    model.strings = @[ContentVideoMaxHeadURL,ContentVideoMaxFootURL,ContentVideoMinHeadURL,ContentVideoMinFootURL];
    UINavigationController *nvc3 = nvcBlock(model);
    
    NSArray *viewControllers=@[nvc1,nvc2,nvc3];
    self.viewControllers=viewControllers;
}


@end
