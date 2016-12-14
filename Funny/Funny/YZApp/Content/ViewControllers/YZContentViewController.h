//
//  YZContentViewController.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperThirdViewController.h"
#import "YZContentWebViewController.h"
#import "YZContentMacro.h"

@interface YZContentViewController : YZSuperThirdViewController
@property (assign ,nonatomic) long long maxTime;
@property (assign ,nonatomic) long long minTime;
//下拉
@property (nonatomic, copy) NSString *pullHeaderStr;
@property (nonatomic, copy) NSString *pullFooterStr;
//上啦
@property (nonatomic, copy) NSString *pushHeaderStr;
@property (nonatomic, copy) NSString *pushFooterStr;
@property (nonatomic, copy, readonly) NSString *normalURLStr;
- (NSString *)getURLString:(RefreshType)refresh;
- (void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView;
@end
