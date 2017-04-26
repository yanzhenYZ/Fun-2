//
//  YZQRScanningViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/2.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZQRScanningViewController.h"
#import "YZQRScanViewController.h"
#import "YZYKPlayerViewController.h"
#import "YZYingKeModel.h"
#import "YZYKDBModel.h"
#import "YZDBManager.h"
#import "YZYingKeMacro.h"
#import "MBProgressHUD+YZZ.h"
#import <AVFoundation/AVFoundation.h>

static const CGFloat SCANWH = 300.0;

@interface YZQRScanningViewController ()<AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, assign) BOOL is3DTouch;
@property (nonatomic, assign) BOOL isLive;

@end

@implementation YZQRScanningViewController

- (instancetype)initWith3DTouch:(BOOL)is3DTouch{
    self = [super init];
    if (self) {
        _is3DTouch = is3DTouch;
    }
    return self;
}

- (instancetype)initWithLive:(BOOL)live{
    self = [super init];
    if (self) {
        _isLive = live;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self startScanning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view.layer addSublayer:self.maskLayer];
    
    UIImageView *scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    scanNetImageView.userInteractionEnabled = YES;
    scanNetImageView.frame = CGRectMake(0, -SCANWH, SCANWH, SCANWH);
    CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
    scanNetAnimation.keyPath = @"transform.translation.y";
    scanNetAnimation.byValue = @(SCANWH);
    scanNetAnimation.duration = 1.0;
    scanNetAnimation.repeatCount = MAXFLOAT;
    scanNetAnimation.fillMode = kCAFillModeForwards;
    scanNetAnimation.removedOnCompletion = NO;
    [scanNetImageView.layer addAnimation:scanNetAnimation forKey:nil];
    [_imageView addSubview:scanNetImageView];
}

#pragma mark - Photo
- (IBAction)scanPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{
        [MBProgressHUD showMessage:@"正在识别" toView:self.view];
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:^{
        [self readQRWithImage:image];
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [MBProgressHUD hideHUDForView:self.view];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

- (void)readQRWithImage:(UIImage *)image{
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    if (ciImage) {
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:[CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}] options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
        NSArray *array = [detector featuresInImage:ciImage];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (array.count > 0) {
            for (CIFeature *feature in array) {
                if ([feature isKindOfClass:[CIQRCodeFeature class]]) {
                    CIQRCodeFeature *qrFeature = (CIQRCodeFeature *)feature;
                    [self scanningDone:qrFeature.messageString];
                    return;
                }
            }
        }
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"无法识别您选中的图片" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
    }];
}

#pragma mark - scan
- (void)startScanning{
    if (_session) return;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //
    //限制扫描区域
    //http://www.jianshu.com/p/4772d3cb6a43
    CGFloat scanWH = 300;
    CGFloat scanX = (HEIGHT - scanWH) / 2 / HEIGHT;
    CGFloat scanY = (WIDTH - scanWH) / 2 / WIDTH;
    output.rectOfInterest = CGRectMake(scanX, scanY, scanWH / HEIGHT + scanX, scanWH / WIDTH + scanY);
    
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetHigh;
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
    }
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    AVCaptureVideoPreviewLayer *previewLayer= [AVCaptureVideoPreviewLayer layerWithSession:_session];
    previewLayer.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    [_session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        [self scanningDone:obj.stringValue];
    }
}

- (void)scanningDone:(NSString *)value{
    if (_is3DTouch) {
        [self touchAction:value];
    }else if (_isLive){
        [_session stopRunning];
        [self liveAction:value];
    }else{
        [_scanVC scanningDone:value];
        [_session stopRunning];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)liveAction:(NSString *)value{
//    model.stream_addr = [NSString stringWithFormat:YK_Live_Header,@"1481618515_4EFB6FC4-617E-48FB-B93F-F561795125EC"];
    NSString *stream_addr = [NSString stringWithFormat:YK_Live_Header,value];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:value preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"输入好友的名字";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSString *name = alert.textFields[0].text;
        if (name.length > 0) {
            YZYKDBModel *model = [[YZYKDBModel alloc] initWithName:name address:value];
            [YZDBManager addLive:model];
        }
    }];
    YZBlockSelf(self)
    UIAlertAction *liveAction = [UIAlertAction actionWithTitle:@"看直播" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *name = alert.textFields[0].text;
        name = name.length > 0 ? name : @"好友";
        YZYKDBModel *live = [[YZYKDBModel alloc] initWithName:name address:value];
        [YZDBManager addLive:live];
        YZYKPlayerViewController *vc = [[YZYKPlayerViewController alloc] initWithStream_addr:stream_addr img:nil];
        [blockself.navigationController pushViewController:vc animated:YES];
    }];
    [alert addAction:liveAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)touchAction:(NSString *)value{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:value preferredStyle:UIAlertControllerStyleAlert];
    if ([value isURLOrNot]) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"打开网址" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:value] options:@{} completionHandler:nil];
        }];
        [alert addAction:sureAction];
    }
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    if (self.isLive) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - maskLayer
//创建一个去除中心扫描区域的layer
-(CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = [self creatMaskLayerWithExceptRect:CGRectMake((WIDTH - 300) * 0.5, (HEIGHT - 300) * 0.5, 300, 300)];
        _maskLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    }
    return _maskLayer;
}

- (CAShapeLayer *)creatMaskLayerWithExceptRect:(CGRect)exceptRect{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    CGFloat exceptX = exceptRect.origin.x;
    CGFloat exceptY = exceptRect.origin.y;
    CGFloat exceptW = exceptRect.size.width;
    CGFloat exceptH = exceptRect.size.height;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, WIDTH, exceptY)];
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, exceptY, exceptX, exceptH)]];
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, exceptY + exceptH, WIDTH, exceptY)]];
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(exceptX + exceptW, exceptY, exceptX, exceptH)]];
    layer.path = path.CGPath;
    return layer;
}
@end
