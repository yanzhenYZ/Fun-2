//
//  YZDrawPictureViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZDrawPictureViewController.h"
#import "YZPaintingImageView.h"
#import "YZPaintingView.h"
#import "MBProgressHUD+YZZ.h"

@interface YZDrawPictureViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet YZPaintingView *paintingView;
@property (strong, nonatomic) YZPaintingImageView *dpView;
@end

@implementation YZDrawPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"画图";
}
- (IBAction)revoke:(id)sender {
    [_paintingView undo];
}

- (IBAction)clear:(id)sender {
    [_paintingView clearScreen];
}

- (IBAction)eraser:(id)sender {
    _paintingView.color = [UIColor whiteColor];
}
- (IBAction)photo:(id)sender {
    [self clear:nil];
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (IBAction)paintingPicture:(id)sender {
    if (_dpView) {
        [_dpView drawInPictureStart];
    }
}
- (IBAction)savePicture:(id)sender {
    if (![_paintingView isDrawInView]) {
        [MBProgressHUD showError:@"您没进行任何操作"];
        return;
    }
    UIImage *newImage = [UIImage imageWithCaptureView:_paintingView];
    [[GlobalManager shareManager] saveImage:newImage];
}

#pragma mark - imagePicker delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //_paintView.image=image;
    _dpView = [[YZPaintingImageView alloc] initWithFrame:_paintingView.frame];
    __block YZDrawPictureViewController *blockSelf = self;
    _dpView.block = ^(UIImage *image){
        blockSelf.paintingView.image = image;
    };
    _dpView.image = image;
    [self.view addSubview:_dpView];
    _paintingView.color = [UIColor blackColor];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sliderValueChanged:(UISlider *)sender {
    _paintingView.width = sender.value;
}

- (IBAction)selectedColor:(UIButton *)sender {
    _paintingView.color = sender.backgroundColor;
}

@end
