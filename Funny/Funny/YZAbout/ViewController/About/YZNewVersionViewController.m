//
//  YZNewVersionViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZNewVersionViewController.h"

@interface YZNewVersionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation YZNewVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _textView.text = @"16.12.14:全新UI\n16.12.20:新增设置图片时，可以截取部分图片\n17.03.03:模仿Facetim页面效果";
}

-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton");
    }];
    return @[action];
}
@end
