//
//  YZBuDeJieViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZBuDeJieViewController.h"

@interface YZBuDeJieViewController ()

@end

@implementation YZBuDeJieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self budejieSuperRefresh];
    [self netRequestWithRefresh:RefreshType_NORMAL baseView:nil];
}

- (void)budejieSuperRefresh
{
    //下拉刷新无内容
    self.footer=[YZRefreshFooterView footer];
    self.footer.scrollView=self.tableView;
    YZWeakSelf(self)
    self.footer.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:RefreshType_PUSH baseView:baseView];
    };
}

-(void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView{
    
}
@end
