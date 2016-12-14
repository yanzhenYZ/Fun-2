//
//  YZYKMyLiveAddressViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/13.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKMyLiveAddressViewController.h"
#import "YZYKLiveAddress.h"
#import "YZQRMakeTool.h"

@interface YZYKMyLiveAddressViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation YZYKMyLiveAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"扫一扫看我直播";
    _imageView.image = [YZQRMakeTool makeQRWithString:[YZYKLiveAddress getSelfLiveAddress]];
}



@end
