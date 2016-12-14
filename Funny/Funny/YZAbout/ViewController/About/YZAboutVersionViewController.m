//
//  YZAboutVersionViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZAboutVersionViewController.h"
#import "YZNewVersionViewController.h"

@interface YZAboutVersionViewController ()<UIViewControllerPreviewingDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *aboutIV;
@property (weak, nonatomic) IBOutlet UIImageView *versionIV;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@end

@implementation YZAboutVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于";
    _aboutIV.image = [UIImage imageNamedWithHZW:@"aboutFunny"];
    NSData *data = [NSData dataWithContentsOfFile:[self filePath]];
    if (data.length > 0) {
        UIImage *image = [UIImage imageWithData:data];
        _aboutIV.image = image;
    }
    _versionIV.image = [UIImage imageNamedWithFunny:@"version"];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    self.versionLabel.text = version;
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}

- (NSString *)filePath{
    return [DocumentsPath stringByAppendingPathComponent:@"about/image.data"];
}
- (IBAction)changeAboutImage:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _aboutIV.image = image;
    NSData *data = UIImagePNGRepresentation(image);
    NSString *filePath = [DocumentsPath stringByAppendingPathComponent:@"about"];
    NSError *error;
    [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    if (error) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    [data writeToFile:[filePath stringByAppendingPathComponent:@"image.data"] atomically:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    return [[YZNewVersionViewController alloc] init];
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [self showViewController:viewControllerToCommit sender:self];
}
@end
