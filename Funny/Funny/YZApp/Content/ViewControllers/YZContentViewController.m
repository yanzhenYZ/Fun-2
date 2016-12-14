//
//  YZContentViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZContentViewController.h"

@interface YZContentViewController ()

@end

@implementation YZContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self superRefresh];
    [self netRequestWithRefresh:RefreshType_NORMAL baseView:nil];
}

- (void)superRefresh{
    self.header = [YZRefreshHeaderView header];
    self.footer = [YZRefreshFooterView footer];
    self.header.scrollView = self.tableView;
    self.footer.scrollView = self.tableView;
    YZWeakSelf(self)
    self.header.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:RefreshType_PULL baseView:baseView];
    };
    self.footer.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:RefreshType_PUSH baseView:baseView];
    };
}

- (NSString *)getURLString:(RefreshType)refresh{
    NSString *urlString=@"";
    if (refresh == RefreshType_NORMAL) {
        urlString = self.normalURLStr;
    }else if (refresh == RefreshType_PULL){
        urlString=[self.pullHeaderStr stringByAppendingFormat:@"%lld", self.maxTime];
        urlString=[urlString stringByAppendingString:self.pullFooterStr];
    }else if(refresh == RefreshType_PUSH){
        urlString=[self.pushHeaderStr stringByAppendingFormat:@"%lld", self.minTime];
        urlString=[urlString stringByAppendingString:self.pushFooterStr];
    }
    return urlString;
}

- (void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView{
    
}

@end
