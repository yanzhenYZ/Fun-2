//
//  YZSuperSecondViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperSecondViewController.h"
#import "YZShotPartView.h"
#import "AppDelegate.h"
#import <YZUIKit/YZUIKit.h>

@interface YZSuperSecondViewController ()<YZCircularMenuDelegate,YZShotPartViewDelegate>
@property (nonatomic, strong) YZShotPartView *shotPartView;
@end

@implementation YZSuperSecondViewController

-(YZShotPartView *)shotPartView{
    if (!_shotPartView) {
        _shotPartView = [[YZShotPartView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49)];
        _shotPartView.delegate = self;
    }
    return _shotPartView;
}

//重写父类---关于---
- (void)superAboutMy{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *menuItemImage = [UIImage imageNamedWithFunny:@"menu_bg"];
    YZCircularMenuItem *(^menuItemBlock)(NSString *contentImageName) = ^(NSString *contentImageName){
        UIImage *contentImage = [UIImage imageNamedWithFunny:contentImageName];
        return [[YZCircularMenuItem alloc] initWithImage:menuItemImage highlightedImage:nil ContentImage:contentImage highlightedContentImage:nil];
    };
    NSArray *menuItems = @[menuItemBlock(@"shotPart"),menuItemBlock(@"home"),menuItemBlock(@"exit"),menuItemBlock(@"my")];
    YZCircularMenuItem *startItem = [[YZCircularMenuItem alloc] initWithImage:[UIImage imageNamedWithFunny:@"menu"]
                                                             highlightedImage:nil
                                                                 ContentImage:[UIImage imageNamedWithFunny:@"plus"]
                                                      highlightedContentImage:[UIImage imageNamedWithFunny:@"plusHL"]];
    YZCircularMenu *menu = [[YZCircularMenu alloc] initWithFrame:CGRectMake(0, HEIGHT - 200 - 49, 200, 200) startItem:startItem startPoint:CGPointMake(20, 180) menuWholeAngle:M_PI_2 menuItems:menuItems];
    menu.delegate = self;
    menu.alpha = 0.5;
    [self.view addSubview:menu];
}

- (void)showActionSheet{
    YZActionSheetItem *titleItem = [[YZActionSheetItem alloc] initWithTitle:@"退出程序" color:nil font:0];
    YZActionSheetItem *item = [[YZActionSheetItem alloc] initWithTitle:@"确定" color:nil font:0];
    YZActionSheet *sheet = [[YZActionSheet alloc] initWithTitle:titleItem cancelItem:nil actionItems:@[item] didSelect:^(NSInteger index) {
        if (index == 1) {
            exit(0);
        }
    }];
    AppDelegate *appDelegate = SharedAppDelegate;
    [sheet showInView:appDelegate.window];
}
#pragma mark - YZShotPartViewDelegate
-(void)shotPart:(BOOL)shot frme:(CGRect)rect{
    [self.shotPartView removeFromSuperview];
    self.shotPartView = nil;
    if (shot) {
        UIImage *image = [UIImage imageWithCaptureView:self.view];
        [self saveImage:image frame:rect];
    }
}

- (void)saveImage:(UIImage *)oldImage frame:(CGRect)frame
{
    CGFloat scale = [UIScreen mainScreen].scale;
    frame.origin.x    *= scale;
    frame.origin.y    *= scale;
    frame.size.width  *= scale;
    frame.size.height *= scale;
    CGImageRef imageRef = oldImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(frame.origin.x, frame.origin.y + 64 * scale, frame.size.width, frame.size.height));
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, frame, subImageRef);
    UIImage* newImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext(); //返回裁剪的部分图像
    [[GlobalManager shareManager] saveImage:newImage];
    
}

#pragma mark -  YZCircularMenuDelegate
-(void)yz_CircularMenu:(YZCircularMenu *)menu didSelectIndex:(NSInteger)index{
    menu.alpha = 0.5;
    if (0 == index) {
        [self.view addSubview:self.shotPartView];
    }else if (1 == index){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (2 == index){
        [self showActionSheet];
    }else if (3 == index){
        [self aboutMyInfo];
    }
}

-(void)yz_CircularMenuWillAnimateOpen:(YZCircularMenu *)menu{
    menu.alpha = 1.0;
}

-(void)yz_CircularMenuWillAnimateClose:(YZCircularMenu *)menu{
    menu.alpha = 0.5;
}
@end
