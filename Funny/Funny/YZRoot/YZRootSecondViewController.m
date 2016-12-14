//
//  YZRootSecondViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/24.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZRootSecondViewController.h"
#import "YZIconButton.h"
#import <YZUIKit/YZTransition.h>

@interface YZRootSecondViewController ()
@property (nonatomic, strong) YZTransition *transition;
@end

@implementation YZRootSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *titles = @[@"画图",@"记事本",@"二维码"];
    NSArray *images = @[@"drawPicture",@"note",@"QR"];
    [images enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger row = idx % 4;
        NSInteger col = idx / 4;
        CGFloat spaceX = (WIDTH - IconWidth * 4) / 5.0;
        YZIconButton *button = [YZIconButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(spaceX + (spaceX + IconWidth) * row, RootTopSpace + (IconHeight + 20) * col, IconWidth, IconHeight);
        button.tag = YZAPPNAME_DRAWPICTURE + idx;
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
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    nvc.modalPresentationStyle = UIModalPresentationCustom;
    _transition = [[YZTransition alloc] init];
    Rotation rotation = {0,1,0,M_PI_2};
    _transition.rotation = rotation;
    _transition.type = YZTransitionTypeCustom;
    nvc.transitioningDelegate = _transition;
    [self.navigationController presentViewController:nvc animated:YES completion:nil];
}
@end
