//
//  YZAboutDeclartionViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZAboutDeclartionViewController.h"

@interface YZAboutDeclartionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *declartionLabel;
@end

@implementation YZAboutDeclartionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"声明";
    _declartionLabel.text = @"I use a lot of network resources.\nThis app is just for personal use, and does not for any commercial use。\n\nApp主要适用于 iPhone 6、iPhone 6s、iPhone 7，其他设备可能存在问题。";
}


@end
