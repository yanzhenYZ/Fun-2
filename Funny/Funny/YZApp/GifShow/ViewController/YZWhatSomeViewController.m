//
//  YZWhatSomeViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWhatSomeViewController.h"
#import "YZContentWebViewController.h"
#import "YZWhatSomeTableViewCell.h"
#import "YZWhatSomeFrame.h"
#import "GifShowMacro.h"

@interface YZWhatSomeViewController ()

@end

@implementation YZWhatSomeViewController

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
        NSArray *modelArray = [YZWhatSomeModel mj_objectArrayWithKeyValuesArray:dataArray];
        for (YZWhatSomeModel *model in modelArray) {
            if (!model.group || !model.group.middle_image) continue;
            YZWhatSomeFrame *frame = [[YZWhatSomeFrame alloc] init];
            frame.model = model;
            if (RefreshType_PULL == refresh) {
                [self.dataSource insertObject:frame atIndex:0];
            }else{
                [self.dataSource addObject:frame];
            }
        }
        [baseView endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSString *error) {
        YZLog(@"Error:%@",error);
    }];
}

-(NSString *)normalURLStr{
    return SomeWhatDefaultPictureURL;
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZWhatSomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZWhatSomeTableViewCell"];
    if (!cell) {
        cell = [[YZWhatSomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YZWhatSomeTableViewCell"];
    }
    cell.pictureFrame = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZWhatSomeFrame *frame = self.dataSource[indexPath.row];
    return frame.rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YZWhatSomeFrame *frame = self.dataSource[indexPath.row];
    YZContentWebViewController *wvc = [[YZContentWebViewController alloc] initWithUrlString:frame.model.group.share_url];
    [self.navigationController pushViewController:wvc animated:YES];
}

@end
