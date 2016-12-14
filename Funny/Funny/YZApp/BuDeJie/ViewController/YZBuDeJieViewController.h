//
//  YZBuDeJieViewController.h
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperThirdViewController.h"
#import "YZBudeJieWebViewController.h"
#import "BuDeJieMacro.h"

@interface YZBuDeJieViewController : YZSuperThirdViewController
@property (copy, nonatomic) NSString *maxid;
@property (copy, nonatomic) NSString *maxtime;
-(void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView;
@end
