//
//  YZNetEaseTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZNetEaseTabBarViewController.h"
#import "YZNetEaseViewController.h"
#import "YZNVCModel.h"
#import "NetEaseMacro.h"

@interface YZNetEaseTabBarViewController ()

@end

@implementation YZNetEaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *(^nvcBlock)(YZNVCModel *model) = ^(YZNVCModel *model){
        YZNetEaseViewController *vc = [[NSClassFromString(model.vcName) alloc] init];
        vc.defaultURL = model.strings[0];
        vc.pushURL    = model.strings[1];
        vc.key        = model.strings[2];
        vc.index      = model.strings[3].longLongValue;
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
    model.vcName = @"YZNetEaseViewController";
    model.title = @"头条";
    model.imageHeader = @"weibo_home";
    model.strings = @[NetEaseHeadLineDefaultURL,NetEaseHeadLinePushURL,@"T1348647909107",@"7"];
    UINavigationController *nvc1 = nvcBlock(model);
    
    model.title = @"原创";
    model.imageHeader = @"weibo_compose";
    model.strings = @[NetEaseOriginalDefaultURL,NetEaseOriginalPushURL,@"T1370583240249",@"1"];
    UINavigationController *nvc2 = nvcBlock(model);
    
    model.title = @"娱乐";
    model.imageHeader = @"weibo_message";
    model.strings = @[NetEasePlayDefaultURL,NetEasePlayPushURL,@"T1348648517839",@"1"];
    UINavigationController *nvc3 = nvcBlock(model);
    
    model.title = @"体育";
    model.imageHeader = @"weibo_favorite";
    model.strings = @[NetEaseSportDefaultURL,NetEaseSportPushURL,@"T1348649079062",@"1"];
    UINavigationController *nvc4 = nvcBlock(model);
    
    self.viewControllers = @[nvc1,nvc2,nvc3,nvc4];
}



@end
