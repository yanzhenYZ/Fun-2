//
//  YZAVTypes.h
//  YZPlayer
//
//  Created by yanzhen.
//

#ifndef YZAVTypes_h
#define YZAVTypes_h

typedef struct{
    Float64 totalTime;   //av total time
    Float64 currentTime; //av current time
    Float64 loadedTime;  //av loaded time
}YZAVTime;

typedef NS_ENUM(NSUInteger, YZAVVideoGravityType) {
    YZAVVideoGravityResizeAspect,
    YZAVVideoGravityResizeAspectFill,
    YZAVVideoGravityResize
};

typedef NS_ENUM(NSInteger, YZAVPlayStatus) {
    YZAVPlayStatusPaused,
    YZAVPlayStatusWaitingToPlay,
    YZAVPlayStatusPlaying,
    YZAVPlayStatusUnknow
} NS_ENUM_AVAILABLE_IOS(10_0);

#endif /* YZAVTypes_h */
