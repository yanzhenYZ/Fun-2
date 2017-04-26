//
//  YZWalfareTextViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfareTextViewController.h"
#import "YZWalfareTextTableViewCell.h"
#import "YZWalfareTextFrame.h"

@interface YZWalfareTextViewController ()

@end

@implementation YZWalfareTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView{
    NSString *urlString = [self getURLString:refresh];
    [NetManager requestDataWithURLString:urlString finished:^(id responseObj) {
        NSArray *itemsArray=responseObj[@"items"];
        NSArray *models = [YZWalfareTextModel mj_objectArrayWithKeyValuesArray:itemsArray];
        for (YZWalfareTextModel *model in models) {
            YZWalfareTextFrame *frame = [[YZWalfareTextFrame alloc] init];
            frame.textModel = model;
            [self.dataSource addObject:frame];
        }
        YZWalfareTextFrame *frame = self.dataSource.lastObject;
        self.max_timestamp = frame.textModel.update_time;
        [baseView endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSString *error) {
        YZLog(@"ERROR:%@",error);
    }];
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZWalfareTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZWalfareTextTableViewCell"];
    if (!cell) {
        cell = [[YZWalfareTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YZWalfareTextTableViewCell"];
    }
    [cell configure:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZWalfareTextFrame *frame = self.dataSource[indexPath.row];
    return frame.rowHeight;
}


@end
