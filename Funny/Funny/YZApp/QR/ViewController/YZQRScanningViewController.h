//
//  YZQRScanningViewController.h
//  Funny
//
//  Created by yanzhen on 16/12/2.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZQRScanViewController;
@interface YZQRScanningViewController : UIViewController
@property (nonatomic, weak) YZQRScanViewController *scanVC;
- (instancetype)initWith3DTouch:(BOOL)is3DTouch;
- (instancetype)initWithLive:(BOOL)live;
@end
