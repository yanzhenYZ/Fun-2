//
//  YZVideoTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZVideoTableViewCell.h"
#import "AppDelegate.h"
#import "WXApi.h"

#define BUFFER_SIZE 1024 * 100
#define YZLABELFONT 14

@interface YZVideoTableViewCell ()
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation YZVideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILongPressGestureRecognizer *l = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGestureAction:)];
        [self addGestureRecognizer:l];
        
        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
        [self addGestureRecognizer:pin];
        [self videoTableViewCellConfigUI];
    }
    return self;
}

- (void)longGestureAction:(UILongPressGestureRecognizer *)l{
        if (l.state == UIGestureRecognizerStateBegan) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = self.shareTitle ? self.shareTitle : @"搞笑视频";
            NSData *data = UIImageJPEGRepresentation(self.mainImageView.image, 0.3);
            //不做无限压缩
            CGFloat scale = 0.2;
            for (int i = 0; i < 3; i++) {
                scale *= 0.5;
                if (data.length / 1000 > 16) {
                    data = UIImageJPEGRepresentation(self.mainImageView.image, scale);
                }else{
                    break;
                }
            }
            UIImage *image = [UIImage imageWithData:data];
            if (data.length / 1000 > 17) {
                image = [UIImage imageNamedWithFunny:@"play"];
            }
            [message setThumbImage:image];
    
            WXVideoObject *ext = [WXVideoObject object];
            ext.videoUrl = self.shareURL ? self.shareURL : @"http://www.baidu.com";
            message.mediaObject = ext;
    
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];
        }
}


- (void)playBtnClick{
    AppDelegate *appDelegate = SharedAppDelegate;
    if (!appDelegate.avWindow.hidden) {
        appDelegate.avWindow.coverImage = self.mainImageView.image;
        [appDelegate.avWindow playAV:self.shareURL];
        return;
    }
    self.playBtn.selected = !self.playBtn.selected;
    if (!self.playBtn.isSelected) {
        [_mainImageView pause];
        return;
    }
    if (self.mainImageView.isPausing) {
        [_mainImageView play];
        return;
    }
    YZWeakSelf(self)
    [_mainImageView playVideo:self.shareURL beignBlock:nil finishedBlock:^{
        weakself.playBtn.selected = !weakself.playBtn.selected;
        [weakself.progressView setProgress:0 animated:NO];
    } failedBlock:nil succeedBlock:^(YZAVTime time) {
        [weakself.progressView setProgress:time.currentTime / time.totalTime animated:YES];
    }];

}

- (void)pinAction:(UIPinchGestureRecognizer *)pin{
    if (pin.state == UIGestureRecognizerStateBegan) {
        if (self.playBtn.isSelected || self.mainImageView.isPausing) {
            self.playBtn.selected = NO;
            [self.progressView setProgress:0 animated:NO];
            AppDelegate *appDelegate = SharedAppDelegate;
            appDelegate.avWindow.hidden = NO;
            appDelegate.avWindow.coverImage = self.mainImageView.image;
            [self.mainImageView reset];
            [appDelegate.avWindow playAV:self.shareURL];
        }
    }
}

- (void)videoTableViewCellConfigUI{
    _mainImageView = [[YZAVView alloc] initWithFrame:CGRectMake(10, 0, WIDTH - 20, 0)];
    _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    _mainImageView.clipsToBounds = YES;
    [self.contentView addSubview:_mainImageView];
    
    YZAVMark *mark = [[YZAVMark alloc] init];
    mark.mark = @"Y&Z TV";
    mark.rect = CGRectMake(5, 0, 120, 40);
    mark.attrs = @{
                   NSForegroundColorAttributeName: YZColor(255, 155, 23),
                   NSFontAttributeName: [UIFont fontWithName:@"IowanOldStyle-BoldItalic" size:16]
                   };
    _mainImageView.mark = mark;
    
    _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    _playBtn.backgroundColor = [UIColor clearColor];
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"play_start"] forState:UIControlStateNormal];
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"play_pause"] forState:UIControlStateSelected];
    [_playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_playBtn];
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.mainImageView.frame), WIDTH - 20, 2)];
    _progressView.progressTintColor = YZColor(255, 155, 23);
    _progressView.progress = 0.0;
    [self.contentView addSubview:_progressView];
}

-(void)setVideoViewFrame:(CGRect)videoViewFrame
{
    _videoViewFrame = videoViewFrame;
    _mainImageView.frame = videoViewFrame;
    _playBtn.frame = CGRectMake(CGRectGetMaxX(videoViewFrame) - 70, CGRectGetMaxY(videoViewFrame) - 62, 70, 62);
    _progressView.frame = CGRectMake(videoViewFrame.origin.x, CGRectGetMaxY(videoViewFrame), videoViewFrame.size.width, 2);
}

- (void)tableViewReload{
    self.playBtn.selected = NO;
    [self.progressView setProgress:0 animated:NO];
    [self.mainImageView reset];
}

-(void)dealloc{
    [self.mainImageView reset];
}

@end
