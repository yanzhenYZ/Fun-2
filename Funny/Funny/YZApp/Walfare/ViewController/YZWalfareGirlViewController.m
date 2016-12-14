//
//  YZWalfareGirlViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfareGirlViewController.h"
#import "YZWalfarePictureTableViewCell.h"
#import "YZWalfareGirlFrame.h"

@interface YZWalfareGirlViewController ()

@end

@implementation YZWalfareGirlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView{
    NSString *urlString = [self getURLString:refresh];
    [NetManager requestDataWithURLString:urlString finished:^(id responseObj) {
        NSArray *itemsArray=responseObj[@"items"];
        NSArray *models = [YZWalfareGirlModel mj_objectArrayWithKeyValuesArray:itemsArray];
        for (YZWalfareGirlModel *model in models) {
            YZWalfareGirlFrame *frame = [[YZWalfareGirlFrame alloc] init];
            frame.girlModel = model;
            [self.dataSource addObject:frame];
        }
        YZWalfareGirlFrame *frame = self.dataSource.lastObject;
        self.max_timestamp = frame.girlModel.update_time;
        [baseView endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSString *error) {
        YZLog(@"ERROR:%@",error);
    }];
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZWalfarePictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZWalfarePictureTableViewCell"];
    if (!cell) {
        cell = [[YZWalfarePictureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YZWalfarePictureTableViewCell"];
    }
    cell.girlFrame = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZWalfareGirlFrame *frame = self.dataSource[indexPath.row];
    return frame.rowHeight;
}

@end
