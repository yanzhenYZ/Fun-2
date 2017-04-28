//
//  YZYKBeautyViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/14.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKBeautyViewController.h"
#import "YZYKLiveAddress.h"
#import "YZMediaTool.h"
#import <YZLFLiveKit/YZLFLiveKit.h>

@interface YZYKBeautyViewController ()
@property (nonatomic, strong) LFLiveSession *session;
@property (nonatomic, assign) CGFloat beautyLevel;
@property (nonatomic, assign) CGFloat brightLevel;
@property (weak, nonatomic) IBOutlet UISlider *brightSlider;
@property (weak, nonatomic) IBOutlet UISlider *beautySlider;

@end

@implementation YZYKBeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"美颜设置";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    _beautyLevel = [YZYKLiveAddress getBeautyLevel] * 10;
    _brightLevel = [YZYKLiveAddress getBrightLevel] * 10;
    _beautySlider.value = _beautyLevel;
    _brightSlider.value = _brightLevel;
    [YZMediaTool requestAccessForVideo:nil];
    [YZMediaTool requestAccessForAudio];
    
    _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration]  videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:[YZYKLiveAddress getVideoQuality]]];
    _session.showDebugInfo = NO;
//    _session.preView = self.view;
    _session.beautyLevel = [YZYKLiveAddress getBeautyLevel];
    _session.brightLevel = [YZYKLiveAddress getBrightLevel];
#pragma mark - 可以自定义视频参数--YZMediaTool
//    _session.running = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _session.preView = self.view;
    _session.running = YES;
    
}

- (void)saveAction{
    [YZYKLiveAddress saveBeautyLevel:_beautyLevel];
    [YZYKLiveAddress saveBrightLevel:_brightLevel];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)beautySliderValueChanged:(UISlider *)sender {
    _beautyLevel = sender.value;
    _session.beautyLevel = sender.value / 10;
}

- (IBAction)brightSliderValueChanged:(UISlider *)sender {
    _brightLevel = sender.value;
    _session.brightLevel = sender.value / 10;
}

@end
