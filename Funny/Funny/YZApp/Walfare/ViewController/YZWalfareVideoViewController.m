//
//  YZWalfareVideoViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfareVideoViewController.h"
#import "YZWalfareVideoTableViewCell.h"
#import "YZWalfareVideoFrame.h"
#import "FunnyVideoPlayManage.h"
#import "WindowViewManager.h"

@interface YZWalfareVideoViewController ()<VideoPlayDelegate>

@end

@implementation YZWalfareVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView{
    NSString *urlString = [self getURLString:refresh];
    [NetManager requestDataWithURLString:urlString finished:^(id responseObj) {
        NSArray *itemsArray=responseObj[@"items"];
        NSArray *models = [YZWalfareVideoModel mj_objectArrayWithKeyValuesArray:itemsArray];
        for (YZWalfareVideoModel *model in models) {
            YZWalfareVideoFrame *frame = [[YZWalfareVideoFrame alloc] init];
            frame.videoModel = model;
            [self.dataSource addObject:frame];
        }
        YZWalfareVideoFrame *frame = self.dataSource.lastObject;
        self.max_timestamp = frame.videoModel.update_time;
        [baseView endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSString *error) {
        YZLog(@"ERROR:%@",error);
    }];
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZWalfareVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZWalfareVideoTableViewCell"];
    if (!cell) {
        cell = [[YZWalfareVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YZWalfareVideoTableViewCell"];
        cell.delegate = self;
    }
    [cell configure:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZWalfareVideoFrame *frame = self.dataSource[indexPath.row];
    return frame.rowHeight;
}

#pragma mark - VideoPlayDelegate
-(void)videoPlay:(BOOL)play videoCell:(YZVideoTableViewCell *)videoCell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:videoCell];
    YZWalfareVideoFrame *frame = self.dataSource[indexPath.row];
    if ([WindowViewManager shareWindowViewManager].isWindowViewShow) {
        videoCell.playBtn.selected = NO;
        [[WindowViewManager shareWindowViewManager] videoPlayWithVideoUrlString:frame.videoModel.vplay_url];
    }else{
        [[FunnyVideoPlayManage shareVideoManage] playVideoWithCell:videoCell urlString:frame.videoModel.vplay_url play:play];
    }
}

-(void)playVideoOnWindow:(YZVideoTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YZWalfareVideoFrame *frame = self.dataSource[indexPath.row];
    [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
    [[WindowViewManager shareWindowViewManager] videoPlayCurrentTime:[FunnyVideoPlayManage shareVideoManage].currentTime videoUrlString:frame.videoModel.vplay_url];
}
@end
