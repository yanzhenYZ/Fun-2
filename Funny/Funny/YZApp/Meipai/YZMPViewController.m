//
//  YZMPViewController.m
//  Funny
//
//  Created by yanzhen on 2017/5/9.
//  Copyright © 2017年 v2tech. All rights reserved.
//

#import "YZMPViewController.h"
#import "YZMPSettingView.h"
#import <YZLFLiveKit/YZLFLiveKit.h>

static const CGFloat MPSETHEIGHT = 100;

@interface YZMPViewController ()<YZMPSettingViewDelegate>
@property (nonatomic, strong) UIImageView *videoView;
@property (nonatomic, strong) LFLiveSession *session;
@property (nonatomic, strong) YZMPSettingView *settingView;
@end

@implementation YZMPViewController

-(YZMPSettingView *)settingView{
    if (!_settingView) {
        _settingView = [[YZMPSettingView alloc] initWithFrame:CGRectMake(0, -MPSETHEIGHT, self.view.frame.size.width, MPSETHEIGHT)];
        _settingView.delegate = self;
        [self.view addSubview:_settingView];
    }
    return _settingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    _videoView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _videoView.userInteractionEnabled = YES;
    //视频可能会显示在视图之外
    _videoView.clipsToBounds = YES;
    [self.view addSubview:_videoView];
    
    UIButton *makeFaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    makeFaceBtn.frame = CGRectMake(0, 0, 61, 61);
    makeFaceBtn.center = CGPointMake(self.view.centerX, self.view.height - 60);
    [makeFaceBtn setBackgroundImage:[UIImage imageNamed:@"mp_takePhoto"] forState:UIControlStateNormal];
    [makeFaceBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeFaceBtn];
    
    CGFloat btnWH = 40;
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(self.view.width - btnWH - 10, self.view.height - btnWH - 10, btnWH, btnWH);
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"mp_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    UIButton *switchCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    switchCamera.frame = CGRectMake(self.view.width - btnWH - 10, 20, btnWH, btnWH);
    [switchCamera setBackgroundImage:[UIImage imageNamed:@"mp_switchCamer"] forState:UIControlStateNormal];
    [switchCamera addTarget:self action:@selector(switchCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchCamera];
    
    _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration]  videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium3]];
    _session.showDebugInfo = NO;
    _session.preView = _videoView;
    _session.beautyLevel = 0.5;
    _session.brightLevel = 0.5;
    _session.running = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)didEnterBackground{
    _session.running = NO;
}

- (void)didBecomeActive{
    _session.running = YES;
}

- (void)takePhoto{
    UIImage *image = [UIImage snapshotScreenInView:_videoView];
    [[GlobalManager shareManager] saveImage:image];
}

- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)switchCamera{
    if (_session.captureDevicePosition == AVCaptureDevicePositionFront) {
        _session.captureDevicePosition = AVCaptureDevicePositionBack;
    }else{
        _session.captureDevicePosition = AVCaptureDevicePositionFront;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.settingView.frame;
        if (frame.origin.y == 0) {
            frame.origin.y = -MPSETHEIGHT;
        }else{
            frame.origin.y = 0;
        }
        _settingView.frame = frame;
    }];
}

#pragma mark - YZMPSettingViewDelegate
-(void)beautyValueChanged:(CGFloat)value
{
    _session.beautyLevel = value;
}

-(void)brightValueChanged:(CGFloat)value
{
    _session.brightLevel = value;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
