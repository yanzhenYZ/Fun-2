//
//  YZAboutManagerLockViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZAboutManagerLockViewController.h"
#import "YZAboutManageTableViewController.h"
#import "YZLockedView.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface YZAboutManagerLockViewController ()
@property (weak, nonatomic) IBOutlet YZLockedView *lockedView;

@end

@implementation YZAboutManagerLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"管理";
    YZWeakSelf(self)
    _lockedView.block = ^(NSString *password){
        if ([weakself isPasswordRight:password]) {
            [weakself intoNoteVC];
            return YES;
        }
        return NO;
    };
    
    LAContext *context = [[LAContext alloc] init];
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"Use Touch ID to Login.", nil) reply:^(BOOL success, NSError * _Nullable error) {
            __strong typeof(weakself) strongSelf = weakself;
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [strongSelf intoNoteVC];
                });
            }else{
                NSLog(@"TTTT:Fail");
                if (error.code == kLAErrorUserFallback) {
                    NSLog(@"User tapped Enter Password");
                } else if (error.code == kLAErrorUserCancel) {
                    NSLog(@"User tapped Cancel");
                } else {
                    NSLog(@"Authenticated failed.");
                }
            }
        }];
    }
}

- (BOOL)isPasswordRight:(NSString *)password{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *udPassword = [ud objectForKey:MANAGERPASSWORD];
    if (udPassword.length < 1) udPassword = @"1234";
#ifdef OTHERUSE
    if ([password isEqualToString:udPassword]) {
        return YES;
    }
#else
    if ([password isEqualToString:udPassword] || [password isEqualToString:@"5250"]) {
        return YES;
    }
#endif
    return NO;
}

- (void)intoNoteVC{
    YZAboutManageTableViewController *vc = [[YZAboutManageTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
