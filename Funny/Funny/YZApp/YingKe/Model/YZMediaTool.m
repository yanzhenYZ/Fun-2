//
//  YZMediaTool.m
//  yingke
//
//  Created by yanzhen on 16/12/13.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZMediaTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation YZMediaTool
+(void)requestAccessForVideo:(void (^)(BOOL authorized))handler{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            // 许可对话没有出现，发起授权许可
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    NSLog(@"--用户开启摄像头--");
                }
                handler(granted);
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            // 已经开启授权，可继续
            NSLog(@"--用户开启摄像头--");
            handler(YES);
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            // 用户明确地拒绝授权，或者相机设备无法访问
            NSLog(@"--用户拒绝开启摄像头--");
            handler(NO);
            break;
        default:
            break;
    }
}

+ (void)requestAccessForAudio{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                if (granted) {
                    NSLog(@"--用户开启麦克风--");
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            NSLog(@"--用户开启麦克风--");
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            NSLog(@"--用户拒绝开启麦克风--");
            break;
        default:
            break;
    }
}

/**
 /*两个版本的框架的方法,发现参数稍微有点不一样*/

//    _session = [[LFLiveSession alloc]initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium3] liveType:LFLiveRTMP];

/**    自己定制单声道  */
/*
 LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
 audioConfiguration.numberOfChannels = 1;
 audioConfiguration.audioBitrate = LFLiveAudioBitRate_64Kbps;
 audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
 _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
 */

/**    自己定制高质量音频96K */
/*
 LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
 audioConfiguration.numberOfChannels = 2;
 audioConfiguration.audioBitrate = LFLiveAudioBitRate_96Kbps;
 audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
 _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
 */

/**    自己定制高质量音频96K 分辨率设置为540*960 方向竖屏 */

/*
 LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
 audioConfiguration.numberOfChannels = 2;
 audioConfiguration.audioBitrate = LFLiveAudioBitRate_96Kbps;
 audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
 
 LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
 videoConfiguration.videoSize = CGSizeMake(540, 960);
 videoConfiguration.videoBitRate = 800*1024;
 videoConfiguration.videoMaxBitRate = 1000*1024;
 videoConfiguration.videoMinBitRate = 500*1024;
 videoConfiguration.videoFrameRate = 24;
 videoConfiguration.videoMaxKeyframeInterval = 48;
 videoConfiguration.orientation = UIInterfaceOrientationPortrait;
 videoConfiguration.sessionPreset = LFCaptureSessionPreset540x960;
 
 _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
 */


/**    自己定制高质量音频128K 分辨率设置为720*1280 方向竖屏 */

/*
 LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
 audioConfiguration.numberOfChannels = 2;
 audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
 audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
 
 LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
 videoConfiguration.videoSize = CGSizeMake(720, 1280);
 videoConfiguration.videoBitRate = 800*1024;
 videoConfiguration.videoMaxBitRate = 1000*1024;
 videoConfiguration.videoMinBitRate = 500*1024;
 videoConfiguration.videoFrameRate = 15;
 videoConfiguration.videoMaxKeyframeInterval = 30;
 videoConfiguration.orientation = UIInterfaceOrientationPortrait;
 videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
 
 _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
 */


/**    自己定制高质量音频128K 分辨率设置为720*1280 方向横屏  */

/*
 LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
 audioConfiguration.numberOfChannels = 2;
 audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
 audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
 
 LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
 videoConfiguration.videoSize = CGSizeMake(1280, 720);
 videoConfiguration.videoBitRate = 800*1024;
 videoConfiguration.videoMaxBitRate = 1000*1024;
 videoConfiguration.videoMinBitRate = 500*1024;
 videoConfiguration.videoFrameRate = 15;
 videoConfiguration.videoMaxKeyframeInterval = 30;
 videoConfiguration.landscape = YES;
 videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
 
 _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
 */
@end
