//
//  YZSuperTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperTabBarViewController.h"

@interface YZSuperTabBarViewController ()

@end

@implementation YZSuperTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBar setTintColor:YZColor(255, 133, 25)];
}

-(UINavigationController *)nvcWithVCName:(NSString *)vcName title:(NSString *)title imageNameHeader:(NSString *)imageNameHeader{
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
    UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:vc];
    vc.title = title;
    NSString *uImageName = [imageNameHeader stringByAppendingString:@"_u"];
    NSString *sImageName = [imageNameHeader stringByAppendingString:@"_s"];
    UIImage *unSelectImage = [UIImage imageNamedWithTabBar:uImageName];
    UIImage *selectImage = [UIImage imageNamedWithTabBar:sImageName];
    [nvc.tabBarItem setImage:unSelectImage];
    [nvc.tabBarItem setSelectedImage:selectImage];
    return nvc;
}


@end
