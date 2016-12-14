//
//  YZBuDeJieTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZBuDeJieTabBarViewController.h"
#import "YZBuDeJieVideoViewController.h"
#import "YZBuDeJieTextViewController.h"
#import "BuDeJieMacro.h"

@interface YZBuDeJieTabBarViewController ()

@end

@implementation YZBuDeJieTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *nvc1 = [self nvcWithVCName:@"YZBuDeJieVideoViewController" title:@"视频" imageNameHeader:@"weibo_music"];
    UINavigationController *nvc2 = [self nvcWithVCName:@"YZBuDeJieTextViewController" title:@"段子" imageNameHeader:@"weibo_compose"];
    NSArray *viewControllers = @[nvc1,nvc2];
    self.viewControllers = viewControllers;
}


@end
