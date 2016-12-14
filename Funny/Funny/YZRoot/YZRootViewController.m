//
//  YZRootViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/24.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZRootViewController.h"
#import "YZRootFirstViewController.h"
#import "YZRootSecondViewController.h"
#import "YZQRScanningViewController.h"

@interface YZRootViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) YZRootFirstViewController *firstVC;
@property (nonatomic, strong) YZRootSecondViewController *secondVC;
@end

@implementation YZRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _firstVC = [[YZRootFirstViewController alloc] init];
    _secondVC = [[YZRootSecondViewController alloc] init];
    [self addChildViewController:_firstVC];
    [self addChildViewController:_secondVC];
    CGFloat height = HEIGHT - 64;
    _firstVC.view.frame = CGRectMake(0, 0, WIDTH, height);
    _secondVC.view.frame = CGRectMake(0, height, WIDTH, height);
    [_scrollView addSubview:_firstVC.view];
    [_scrollView addSubview:_secondVC.view];
    _scrollView.contentSize = CGSizeMake(0, height * 2);
    
}

- (void)widgetIntoViewController:(NSInteger)tag{
    //程序直接通过-3DTouch-或者-Widget-启动--[self viewDidLoad]没有被调用，需要手动调用一下
    if (![self isViewLoaded]) [self viewDidLoad];
    
    //tag = 100-103
    //只考虑push和present一级的情况
    if (self.navigationController.presentedViewController) {
        [self.navigationController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }else if (self.navigationController.viewControllers.count > 1){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if (tag < YZAPPNAME_DRAWPICTURE) {
        [_firstVC widgetIntoViewController:tag];
    }else{
        if (tag == 109) {
            YZQRScanningViewController *vc = [[YZQRScanningViewController alloc] initWith3DTouch:YES];
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }else{
            [_secondVC widgetIntoViewController:tag];
        }
    }
}


@end
