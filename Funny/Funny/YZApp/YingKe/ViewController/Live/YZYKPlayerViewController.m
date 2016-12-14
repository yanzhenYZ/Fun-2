//
//  YZYKPlayerViewController.m
//  yingke
//
//  Created by yanzhen on 16/12/8.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKPlayerViewController.h"
#import "YZYingKeModel.h"
//https://github.com/Bilibili/ijkplayer
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface YZYKPlayerViewController ()
@property (nonatomic, strong) YZYingKeModel *model;

@property(atomic, retain) id<IJKMediaPlayback> player;

@property (nonatomic, weak) UIImageView * loadBlurImage;

@property (nonatomic, strong) UIButton * closeBtn;

//@property (nonatomic, strong) SXTLiveChatViewController * liveChatVC;
@end

@implementation YZYKPlayerViewController

- (instancetype)initWithYingKeModel:(YZYingKeModel *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
//    [self installMovieNotificationObservers];
    if (![self.player isPlaying]) {
        [self.player prepareToPlay];
    }
    
//    UIWindow * window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
//    [window addSubview:self.closeBtn];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.player shutdown];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    [self installMovieNotificationObservers];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
//    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:@"rtmp://live.hkstv.hk.lxdns.com:1935/live/Funny" withOptions:options];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.model.stream_addr withOptions:options];
    //rtmp://live.hkstv.hk.lxdns.com:1935/live/Funny
    self.player.view.frame = self.view.bounds;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];
    
    //添加图片
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView yz_setImageWithURL:self.model.creator.portrait placeholderImage:@"default_room"];
    [self.view addSubview:imageView];
    _loadBlurImage = imageView;
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //  毛玻璃view 视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    effectView.frame = imageView.bounds;
    [imageView addSubview:effectView];
    
    UIButton *closeBtn = [[UIButton alloc] init];
    CGFloat wh = 35;
    closeBtn.frame = CGRectMake(WIDTH - wh - 10, HEIGHT - wh - 10, wh, wh);
    [closeBtn setImage:[UIImage imageNamed:@"window_close"] forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    [closeBtn setTitleColor:YZColor(27, 210, 189) forState:UIControlStateNormal];
    closeBtn.layer.masksToBounds = YES;
    closeBtn.layer.cornerRadius = closeBtn.width * 0.5;
    closeBtn.layer.borderWidth = 1.0;
    //YZColor(129, 221, 201)
    closeBtn.layer.borderColor = YZColor(27, 210, 189).CGColor;
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}

- (void)closeBtnClick:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)installMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,
    //    MPMovieLoadStatePlayable       = 1 << 0,
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,
    //    MPMovieFinishReasonPlaybackError,
    //    MPMovieFinishReasonUserExited
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
    
    self.loadBlurImage.hidden = YES;
    [self.loadBlurImage removeFromSuperview];
}


@end
