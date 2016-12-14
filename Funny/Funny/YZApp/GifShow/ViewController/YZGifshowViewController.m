//
//  YZGifshowViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZGifshowViewController.h"
#import "YZGifshowTableViewCell.h"
#import "YZGifshowModel.h"
#import "GifShowMacro.h"
#import "FunnyVideoPlayManage.h"
#import "WindowViewManager.h"

@interface YZGifshowViewController ()<VideoPlayDelegate>

@end

@implementation YZGifshowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = (WIDTH - 100) / 3 * 4 + 82;
    [self gifShowRefresh];
    [self netRequestWithRefresh:RefreshType_PUSH baseView:nil];
}

- (void)gifShowRefresh
{
    self.header=[YZRefreshHeaderView header];
    self.footer=[YZRefreshFooterView footer];
    self.header.scrollView=self.tableView;
    self.footer.scrollView=self.tableView;
    YZWeakSelf(self)
    self.header.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:RefreshType_PULL baseView:baseView];
    };
    self.footer.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:RefreshType_PUSH baseView:baseView];
    };
}

- (void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"os"]         = @"android";
    params[@"client_key"] = @"3c2cd3f3";
    //1--暂时写死
    params[@"last"] = @"62";
    
    params[@"count"] = @"20";
    params[@"token"] = @"";
    //2--暂时写死
    params[@"page"] = @"1";
    
    params[@"pcursor"] = @"";
    params[@"pv"] = @"false";
    params[@"mtype"] = @"2";
    params[@"type"] = @"7";
    //3--暂时写死
    params[@"sig"] = @"030d2819371a88871dfdcef832f8d553";
    [NetManager POSTWithURLString:GifShowHeadURL parameters:params finished:^(id responseObj) {
        NSArray *feedsArray = responseObj[@"feeds"];
        NSArray *modelArray = [YZGifshowModel mj_objectArrayWithKeyValuesArray:feedsArray];
        if (refresh == RefreshType_PULL) {
            for (YZGifshowModel *model in modelArray) {
                [self.dataSource insertObject:model atIndex:0];
            }
        }else{
            [self.dataSource addObjectsFromArray:modelArray];
        }
        [baseView endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSString *error) {
        YZLog(@"Error:%@",error);
    }];
}
#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZGifshowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZGifshowTableViewCell"];
    if (!cell) {
        cell = [[YZGifshowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YZGifshowTableViewCell"];
        cell.delegate = self;
    }
    if (cell.refresh) {
        [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
        cell.playBtn.selected = NO;
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - VideoPlayDelegate
-(void)videoPlay:(BOOL)play videoCell:(YZVideoTableViewCell *)videoCell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:videoCell];
    YZGifshowModel *model = self.dataSource[indexPath.row];
    if ([WindowViewManager shareWindowViewManager].isWindowViewShow) {
        videoCell.playBtn.selected = NO;
        [[WindowViewManager shareWindowViewManager] videoPlayWithVideoUrlString:model.main_mv_url];
    }else{
        [[FunnyVideoPlayManage shareVideoManage] playVideoWithCell:videoCell urlString:model.main_mv_url play:play];
    }
}

-(void)playVideoOnWindow:(YZVideoTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YZGifshowModel *model = self.dataSource[indexPath.row];
    [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
    [[WindowViewManager shareWindowViewManager] videoPlayCurrentTime:[FunnyVideoPlayManage shareVideoManage].currentTime videoUrlString:model.main_mv_url];
}

@end
