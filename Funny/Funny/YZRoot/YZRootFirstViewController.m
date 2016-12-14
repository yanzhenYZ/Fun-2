//
//  YZRootFirstViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/24.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZRootFirstViewController.h"
#import "YZContentTabBarViewController.h"
#import "YZIconButton.h"
#import <YZUIKit/YZTransition.h>

@interface YZRootFirstViewController ()
@property (nonatomic, strong) YZTransition *transition;
@end

@implementation YZRootFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *images = @[@"content",@"gifShow",@"budejie",@"walfare",@"uc",@"netease",@"yingke"];
    NSArray *titles = @[@"内涵段子",@"快手",@"不得姐",@"福利社",@"UC新闻",@"网易新闻",@"直播"];
    [images enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger row = idx % 4;
        NSInteger col = idx / 4;
        CGFloat spaceX = (WIDTH - IconWidth * 4) / 5.0;
        YZIconButton *button = [YZIconButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(spaceX + (spaceX + IconWidth) * row, RootTopSpace + (IconHeight + 20) * col, IconWidth, IconHeight);
        button.tag = YZAPPNAME_CONTENT + idx;
        UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(slectedApp:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titles[idx] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:button];
    }];
}

- (void)slectedApp:(YZIconButton *)btn{
    [self widgetIntoViewController:btn.tag];
}

- (void)widgetIntoViewController:(NSInteger)tag{
    NSString *className = YZApp[tag];
    UITabBarController *tvc = [[NSClassFromString(className) alloc] init];
    tvc.modalPresentationStyle = UIModalPresentationCustom;
    _transition = [[YZTransition alloc] init];
    _transition.type = YZTransitionTypeCustom;
    tvc.transitioningDelegate = _transition;
    [self.navigationController presentViewController:tvc animated:YES completion:nil];
}
@end
