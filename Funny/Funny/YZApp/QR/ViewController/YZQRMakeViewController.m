//
//  YZQRMakeViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/2.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZQRMakeViewController.h"
#import "YZQRMakeTool.h"

@interface YZQRMakeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation YZQRMakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)makeQR:(id)sender {
    if (self.textView.text.length < 1) return;
    [self makeSystemQR];
}

- (void)makeSystemQR{
    self.imageView.image = [YZQRMakeTool makeQRWithString:self.textView.text];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
}
@end
