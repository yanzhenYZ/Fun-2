//
//  YZWalfareViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfareViewController.h"

@interface YZWalfareViewController ()

@end

@implementation YZWalfareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self budejieSuperRefresh];
    [self netRequestWithRefresh:RefreshType_NORMAL baseView:nil];
}

- (void)budejieSuperRefresh
{
    //下拉无数据
    self.footer = [YZRefreshFooterView footer];
    self.footer.scrollView = self.tableView;
    YZWeakSelf(self)
    self.footer.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:RefreshType_PUSH baseView:baseView];
    };
}

- (NSString *)getURLString:(RefreshType)refresh;
{
    if (refresh == RefreshType_PUSH) {
        NSString *urlString = [self.pushHeadURL stringByAppendingString:self.max_timestamp];
        urlString = [urlString stringByAppendingString:WalfarePushDefaultMiddleURL];
        urlString = [urlString stringByAppendingString:self.latest_viewed_ts];
        urlString = [urlString stringByAppendingString:WalfareDefaultFootURL];
        return urlString;
    }else{
        self.latest_viewed_ts = [NSString currentTime];
        return self.defaultURL;
    }
}

- (void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView
{
    
}
@end
