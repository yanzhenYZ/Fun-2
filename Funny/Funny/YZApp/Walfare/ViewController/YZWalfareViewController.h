//
//  YZWalfareViewController.h
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperThirdViewController.h"
#import "WalfareMacro.h"

@interface YZWalfareViewController : YZSuperThirdViewController
@property (copy, nonatomic) NSString *defaultURL;
@property (copy, nonatomic) NSString *pullHeadURL;
@property (copy, nonatomic) NSString *pushHeadURL;
@property (copy, nonatomic) NSString *max_timestamp;
@property (copy, nonatomic) NSString *latest_viewed_ts;

- (NSString *)getURLString:(RefreshType)refresh;
- (void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView;
@end
