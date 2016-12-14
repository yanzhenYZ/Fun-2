//
//  YZQRViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/2.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZQRViewController.h"
#import "YZQRScanViewController.h"
#import "YZQRMakeViewController.h"

@interface YZQRViewController ()
@property (nonatomic, strong) YZQRScanViewController *scanVC;
@property (nonatomic, strong) YZQRMakeViewController *makeVC;
@end

@implementation YZQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"扫描二维码",@"生成二维码"]];
    segment.frame = CGRectMake(0, 0, 150, 30);
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    
    _scanVC = [[YZQRScanViewController alloc] init];
    _makeVC = [[YZQRMakeViewController alloc] init];
    _scanVC.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _makeVC.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [self addChildViewController:_scanVC];
    [self addChildViewController:_makeVC];
    [self.view addSubview:_scanVC.view];
    [self.view addSubview:_makeVC.view];
    [self.view insertSubview:_scanVC.view atIndex:0];
    [self.view insertSubview:_makeVC.view atIndex:0];
}

- (void)segmentAction:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 1) {
        [UIView animateWithDuration:0.25 animations:^{
            _scanVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            self.makeVC.view.alpha = 1;
        }];
    }else{
        [self.makeVC.view endEditing:YES];
        [UIView animateWithDuration:0.25 animations:^{
            self.makeVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            _scanVC.view.alpha = 1;
        }];
    }
}


@end
