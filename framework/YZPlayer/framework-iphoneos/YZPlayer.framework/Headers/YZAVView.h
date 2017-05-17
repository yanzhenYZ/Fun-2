//
//  YZAVView.h
//  YZPlayer
//
//  Created by yanzhen.
//

#import <UIKit/UIKit.h>
#import "YZAVTypes.h"

@protocol YZAVViewDelegate <NSObject>

@optional
- (void)yz_videoPlayFail:(NSError *)error;
- (void)yz_videoPlayProcess:(YZAVTime)time;
- (void)yz_videoPlayBegin;
- (void)yz_videoPlayFinished;

@end

@class YZAVMark;
@interface YZAVView : UIImageView

@property (nonatomic) YZAVVideoGravityType videoGravity;

@property (nonatomic, strong) YZAVMark *mark NS_AVAILABLE_IOS(7_0);

@property (nonatomic, weak) id<YZAVViewDelegate> delegate;

//default is 1.0
@property (nonatomic) NSTimeInterval duration;

/*! default is YES
    when enter background, av will pause,if set YES,when did become active,av will play
    if av be paused before enter background,when did become active,av will not play
 */
@property (nonatomic) BOOL playWhenDidBecomeActive;

@property (nonatomic, readonly) YZAVTime time;

@property (nonatomic, readonly) BOOL isPlaying;

@property (nonatomic, readonly) BOOL isPausing;

-(instancetype)initWithImage:(UIImage *)image UNAVAILABLE_ATTRIBUTE;
-(instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage UNAVAILABLE_ATTRIBUTE;

- (void)playVideo:(NSString *)videoUrlStr beignBlock:(void (^)())begin finishedBlock:(void (^)())finished failedBlock:(void (^)(NSError *error))failed succeedBlock:(void (^)(YZAVTime time))succeed;

//reset av
- (void)reset;

//NSTimer invalidate
- (void)free;
@end

@interface YZAVView (YZAVViewPlay)

- (void)play;

- (void)pause;

@property (nonatomic, readonly) YZAVPlayStatus playStatus NS_AVAILABLE_IOS(10_0);

//play av in a specified rate.
@property (nonatomic) float rate NS_AVAILABLE_IOS(10_0);

//seek to a specified time for the current
- (void)seekToTime:(Float64)time completionHandler:(void (^)(BOOL finished))completionHandler;

@end

