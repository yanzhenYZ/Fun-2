//
//  YZUCTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZUCTabBarViewController.h"
#import "YZUCViewController.h"
#import "YZNVCModel.h"
#import "UCNewsMacro.h"

@interface YZUCTabBarViewController ()

@end

@implementation YZUCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *(^nvcBlock)(YZNVCModel *model) = ^(YZNVCModel *model){
        YZUCViewController *vc = [[NSClassFromString(model.vcName) alloc] init];
        vc.UCNewsHeadURL   = model.strings[0];
        vc.UCNewsMiddleURL = model.strings[1];
        vc.UCNewsFootURL   = model.strings[2];
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
    model.vcName = @"YZUCViewController";
    model.title = @"推荐";
    model.imageHeader = @"weibo_home";
    model.strings = @[UCNewsRecommendHeadURL,UCNewsRecommendMiddleURL,UCNewsRecommendFootURL];
    UINavigationController *nvc1 = nvcBlock(model);
    
    model.title = @"NBA";
    model.imageHeader = @"weibo_compose";
    model.strings = @[UCNewsNBAHeadURL,UCNewsNBAMiddleURL,UCNewsNBAFootURL];
    UINavigationController *nvc2 = nvcBlock(model);
    
    model.title = @"娱乐";
    model.imageHeader = @"weibo_music";
    model.strings = @[UCNewsPlayHeadURL,UCNewsPlayMiddleURL,UCNewsPlayFootURL];
    UINavigationController *nvc3 = nvcBlock(model);
    
    model.title = @"社会";
    model.imageHeader = @"weibo_message";
    model.strings = @[UCNewsSocialHeadURL,UCNewsSocialMiddleURL,UCNewsSocialFootURL];
    UINavigationController *nvc4 = nvcBlock(model);
    
    model.title = @"搞笑";
    model.imageHeader = @"weibo_favorite";
    model.strings = @[UCNewsFunnyHeadURL,UCNewsFunnyMiddleURL,UCNewsFunnyFootURL];
    UINavigationController *nvc5 = nvcBlock(model);
    self.viewControllers = @[nvc1,nvc2,nvc3,nvc4,nvc5];
}


@end
