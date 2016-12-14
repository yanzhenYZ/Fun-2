//
//  YZQRScanViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/2.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZQRScanViewController.h"
#import "YZQRScanningViewController.h"
#import "AppDelegate.h"
#import <YZUIKit/YZTransition.h>

@interface YZQRScanViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *openURLBtn;
@property (nonatomic, strong) YZTransition *transition;
@end

@implementation YZQRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)scanningDone:(NSString *)string{
    self.textView.hidden = NO;
    self.textView.text = string;
    [self dealWithURLString];
}

- (void)dealWithURLString
{
    if ([self.textView.text isURLOrNot]) {
        self.openURLBtn.hidden=NO;
    }
}

- (IBAction)clickToScanning:(id)sender {
    self.textView.text = nil;
    self.openURLBtn.hidden = YES;
    YZQRScanningViewController *vc = [[YZQRScanningViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    _transition = [[YZTransition alloc] init];
    _transition.type = YZTransitionTypeFromUp;
    vc.transitioningDelegate = _transition;
    vc.scanVC = self;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (IBAction)openURLBtnClick:(id)sender {
    if (self.textView.text.length < 1) return;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.textView.text] options:@{} completionHandler:nil];
}


@end
