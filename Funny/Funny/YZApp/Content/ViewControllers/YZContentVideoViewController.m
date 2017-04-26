//
//  YZContentVideoViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZContentVideoViewController.h"
#import "YZContentVideoTableViewCell.h"
#import "YZContentVideoFrame.h"
#import "FunnyVideoPlayManage.h"
#import "WindowViewManager.h"

@interface YZContentVideoViewController ()<VideoPlayDelegate>

@end

@implementation YZContentVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView{
    NSString *urlString=[self getURLString:refresh];
    [NetManager requestDataWithURLString:urlString finished:^(id responseObj) {
        NSDictionary *dataDict = responseObj[@"data"];
        NSNumber *min_time = dataDict[@"min_time"];
        NSNumber *max_time = dataDict[@"max_time"];
        if (RefreshType_NORMAL == refresh) {
            self.minTime = min_time.longLongValue;
            self.maxTime = max_time.longLongValue;
        }else if (RefreshType_PUSH == refresh){
            self.minTime = min_time.longLongValue;
        }else{
            self.maxTime = max_time.longLongValue;
        }
        NSArray *dataArray = dataDict[@"data"];
        NSArray *modelArray = [YZContentModel mj_objectArrayWithKeyValuesArray:dataArray];
        for (YZContentModel *videoModel in modelArray) {
            if (!videoModel.group) continue;
            YZContentVideoFrame *videoFrame = [[YZContentVideoFrame alloc] init];
            videoFrame.contentModel = videoModel;
            if (RefreshType_PULL == refresh) {
                [self.dataSource insertObject:videoFrame atIndex:0];
            }else{
                [self.dataSource addObject:videoFrame];
            }
        }
        [baseView endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSString *error) {
        YZLog(@"Error:%@",error);
    }];
}

-(NSString *)normalURLStr{
    NSString *urlString = [ContentVideoMaxHeadURL stringByAppendingString:[NSString currentTime]];
    return [urlString stringByAppendingString:ContentVideoMaxFootURL];
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZContentVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZContentVideoTableViewCell"];
    if (!cell) {
        cell = [[YZContentVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YZContentVideoTableViewCell"];
        cell.delegate = self;
    }
    [cell configure:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZContentVideoFrame *videoFrame = self.dataSource[indexPath.row];
    return videoFrame.rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YZContentVideoFrame *frame = self.dataSource[indexPath.row];
    YZContentWebViewController *wvc = [[YZContentWebViewController alloc] initWithUrlString:frame.contentModel.group.share_url];
    [self.navigationController pushViewController:wvc animated:YES];
}
#pragma mark - VideoPlayDelegate
-(void)videoPlay:(BOOL)play videoCell:(YZVideoTableViewCell *)videoCell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:videoCell];
    YZContentVideoFrame *frame = self.dataSource[indexPath.row];
    //frame.contentModel.group.mp4_url
    NSString *url = frame.contentModel.group.video_720p.url_list[0][@"url"];
    if ([WindowViewManager shareWindowViewManager].isWindowViewShow) {
        videoCell.playBtn.selected = NO;
        [[WindowViewManager shareWindowViewManager] videoPlayWithVideoUrlString:url];
    }else{
        [[FunnyVideoPlayManage shareVideoManage] playVideoWithCell:videoCell urlString:url play:play];
    }
}

-(void)playVideoOnWindow:(YZVideoTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YZContentVideoFrame *frame = self.dataSource[indexPath.row];
    NSString *url = frame.contentModel.group.video_720p.url_list[0][@"url"];
    [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
    [[WindowViewManager shareWindowViewManager] videoPlayCurrentTime:[FunnyVideoPlayManage shareVideoManage].currentTime videoUrlString:url];
}

@end
