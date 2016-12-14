//
//  YZYKNavigationViewController.m
//  yingke
//
//  Created by yanzhen on 16/12/8.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKNavigationViewController.h"

@interface YZYKNavigationViewController ()

@end

@implementation YZYKNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor * radomcolor = [UIColor colorWithRed:36/255.0 green:215/255.0 blue:200/255.0 alpha:1];
    
    self.navigationBar.barTintColor = radomcolor;
    
    self.navigationBar.tintColor = [UIColor whiteColor];
}

@end
