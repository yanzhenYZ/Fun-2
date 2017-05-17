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

@interface YZWalfareVideoViewController ()

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
    }
    [cell configure:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZWalfareVideoFrame *frame = self.dataSource[indexPath.row];
    return frame.rowHeight;
}
@end
