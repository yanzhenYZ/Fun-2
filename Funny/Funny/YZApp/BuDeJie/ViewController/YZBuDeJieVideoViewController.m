//
//  YZBuDeJieVideoViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZBuDeJieVideoViewController.h"
#import "YZBudeJieVideoTableViewCell.h"
#import "YZBuDeJieVideoFrame.h"
#import "FunnyVideoPlayManage.h"
#import "WindowViewManager.h"

@interface YZBuDeJieVideoViewController ()<VideoPlayDelegate>

@end

@implementation YZBuDeJieVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView{
    NSString *urlString=[self urlStringWithRefresh:refresh];
    [NetManager requestDataWithURLString:urlString finished:^(id responseObj) {
        NSDictionary *infoDict = responseObj[@"info"];
        self.maxtime = infoDict[@"maxtime"];
        NSArray *listArray = responseObj[@"list"];
        NSArray *modelArray = [YZBudeJieVideoModel mj_objectArrayWithKeyValuesArray:listArray];
        for (YZBudeJieVideoModel *videoModel in modelArray) {
            YZBuDeJieVideoFrame *frame = [[YZBuDeJieVideoFrame alloc] init];
            frame.videoModel = videoModel;
            [self.dataSource addObject:frame];
        }
        [baseView endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSString *error) {
        YZLog(@"ERROR:%@",error);
    }];
}

- (NSString *)urlStringWithRefresh:(RefreshType)refresh
{
    if (refresh == RefreshType_PUSH) {
        NSString *urlString=[BuDeJieVideoPushHeadURL stringByAppendingString:self.maxtime];
        return [urlString stringByAppendingString:BuDeJieVideoPushFootURL];
    }else{
        return BuDeJieVideoDefaultURL;
    }
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZBudeJieVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZBudeJieVideoTableViewCell"];
    if (!cell) {
        cell = [[YZBudeJieVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YZBudeJieVideoTableViewCell"];
        cell.delegate = self;
    }
    [cell configure:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZBuDeJieVideoFrame *frame = self.dataSource[indexPath.row];
    return frame.rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YZBuDeJieVideoFrame *frame = self.dataSource[indexPath.row];
    NSLog(@"TTTT:%@",frame.videoModel.weixin_url);
    YZBudeJieWebViewController *wvc = [[YZBudeJieWebViewController alloc] initWithUrlString:frame.videoModel.weixin_url];
    [self.navigationController pushViewController:wvc animated:YES];
}

#pragma mark - VideoPlayDelegate
-(void)videoPlay:(BOOL)play videoCell:(YZVideoTableViewCell *)videoCell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:videoCell];
    YZBuDeJieVideoFrame *frame = self.dataSource[indexPath.row];
    if ([WindowViewManager shareWindowViewManager].isWindowViewShow) {
        videoCell.playBtn.selected = NO;
        [[WindowViewManager shareWindowViewManager] videoPlayWithVideoUrlString:frame.videoModel.videouri];
    }else{
        [[FunnyVideoPlayManage shareVideoManage] playVideoWithCell:videoCell urlString:frame.videoModel.videouri play:play];
    }
}

-(void)playVideoOnWindow:(YZVideoTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YZBuDeJieVideoFrame *frame = self.dataSource[indexPath.row];
    [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
    [[WindowViewManager shareWindowViewManager] videoPlayCurrentTime:[FunnyVideoPlayManage shareVideoManage].currentTime videoUrlString:frame.videoModel.videouri];
}

@end
