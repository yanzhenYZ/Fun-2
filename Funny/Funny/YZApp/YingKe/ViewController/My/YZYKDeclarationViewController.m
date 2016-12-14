//
//  YZYKDeclarationViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/14.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKDeclarationViewController.h"

@interface YZYKDeclarationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *declarationLabel;

@end

@implementation YZYKDeclarationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"声明";
    NSString *declaration = @"1.直播数据来自网络\n2.视频播放库-https://github.com/Bilibili/ijkplayer\n3.直播控件-LFLiveKit\n4.rtmp服务器未知(数据不安全)";
    _declarationLabel.text = declaration;
}



@end
