//
//  YZSuperViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperViewController.h"
#import "YZAboutInfoViewController.h"

@interface YZSuperViewController ()

@end

@implementation YZSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self superAboutMy];
}

- (void)superAboutMy{
    UIImage *image = [UIImage imageNamedWithTabBar:@"weibo_profile_s"];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(aboutMyInfo)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)aboutMyInfo{
    YZAboutInfoViewController *vc = [[YZAboutInfoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
