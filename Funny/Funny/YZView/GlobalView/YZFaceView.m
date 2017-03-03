//
//  YZFaceView.m
//  test
//
//  Created by yanzhen on 17/3/3.
//  Copyright © 2017年 v2tech. All rights reserved.
//

#import "YZFaceView.h"
#import <AVFoundation/AVFoundation.h>

@interface YZFaceView ()
@property (nonatomic, strong) AVCaptureSession *session;
@end

@implementation YZFaceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = frame;
        [self addSubview:effectView];
    }
    return self;
}

- (void)startRunning{
    if (_session.isRunning) return;
    if (_session) {
        [_session startRunning];
        return;
    }
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetHigh;
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    AVCaptureVideoPreviewLayer *previewLayer= [AVCaptureVideoPreviewLayer layerWithSession:_session];
    previewLayer.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer insertSublayer:previewLayer atIndex:0];
    [_session startRunning];
}

- (void)stopRunning{
    [self.session stopRunning];
}
@end
