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
    _textView.text = @"16.12.14:全新UI";
}

-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton");
    }];
    return @[action];
}
@end
