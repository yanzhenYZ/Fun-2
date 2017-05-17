//
//  YZAVWindow.h
//  YZPlayer
//
//  Created by yanzhen
//

#import <UIKit/UIKit.h>
#import "YZAVTypes.h"

@class YZAVMark;
@interface YZAVWindow : UIWindow

@property (nonatomic, strong) UIImage *coverImage;

@property (nonatomic) YZAVVideoGravityType videoGravity;

- (void)playAV:(NSString *)avUrlStr;

- (void)mark:(YZAVMark *)mark NS_AVAILABLE_IOS(7_0);
- (void)setPauseBtnImageName:(NSString *)pause closeBtnImageName:(NSString *)close;

@end
