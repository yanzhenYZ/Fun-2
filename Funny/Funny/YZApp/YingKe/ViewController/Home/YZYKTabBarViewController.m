//
//  YZYKTabBarViewController.m
//  yingke
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKTabBarViewController.h"
#import "YZYKNavigationViewController.h"
#import "YZHomeViewController.h"
#import "YZYKMyTableViewController.h"
#import "YZYKLiveViewController.h"
#import "YZYingKeTabBar.h"

@interface YZYKTabBarViewController ()<YZYingKeTabBarDelegate>
@property (nonatomic, strong) YZYingKeTabBar *tabBarView;
@end

@implementation YZYKTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    YZHomeViewController *hvc = [[YZHomeViewController alloc] init];
    YZYKNavigationViewController *nvc1 = [[YZYKNavigationViewController alloc] initWithRootViewController:hvc];
    
    YZYKMyTableViewController *mvc = [[YZYKMyTableViewController alloc] init];
    YZYKNavigationViewController *nvc2 = [[YZYKNavigationViewController alloc] initWithRootViewController:mvc];
    self.viewControllers = @[nvc1,nvc2];
    
    YZYingKeTabBar *tabBarView = [[YZYingKeTabBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
    tabBarView.delegate = self;
    [self.tabBar addSubview:tabBarView];
    _tabBarView = tabBarView;
}

#pragma mark - YZYingKeTabBarDelegate
-(void)yingkeTabBarButtonClick:(YKTabBarBtnType)type{
    if (type == YKTabBarBtnType_Launch) {
        YZYKLiveViewController *vc = [[YZYKLiveViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        self.selectedIndex = type - YKTabBarBtnType_Home;
    }
}

@end
