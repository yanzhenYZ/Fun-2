//
//  YZManagePasswordViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZManagePasswordViewController.h"
#import "YZTextField.h"
#import "Toast+UIView.h"

@interface YZManagePasswordViewController ()
@property (weak, nonatomic) IBOutlet YZTextField *passwordTF1;
@property (weak, nonatomic) IBOutlet YZTextField *passwordTF2;

@property (nonatomic) PasswordType type;

@end

@implementation YZManagePasswordViewController

- (instancetype)initWithPasswordType:(PasswordType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_type == PasswordType_Manager) {
        _passwordTF1.placeholder = @"请输入4位管理员密码";
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)sureBtnClick:(UIButton *)sender {
    if (self.passwordTF1.text.length == 4 && [self.passwordTF2.text isEqualToString:self.passwordTF1.text]) {
        NSUserDefaults *ud  = [NSUserDefaults standardUserDefaults];
        if (_type == PasswordType_Manager) {
            [ud setObject:self.passwordTF1.text forKey:MANAGERPASSWORD];
        }else if (_type == PasswordType_Note){
            [ud setObject:self.passwordTF1.text forKey:NOTEPASSWORD];
        }
        [ud synchronize];
        self.passwordTF1.text = self.passwordTF2.text = nil;
        [self.view makeCenterToast:@"修改成功"];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"输入密码有误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
