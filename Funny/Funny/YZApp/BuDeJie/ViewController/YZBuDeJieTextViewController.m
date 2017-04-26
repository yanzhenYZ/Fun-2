//
//  YZBuDeJieTextViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZBuDeJieTextViewController.h"
#import "YZBuDeJieTextTableViewCell.h"
#import "YZBuDeJieTextFrame.h"

@interface YZBuDeJieTextViewController ()

@end

@implementation YZBuDeJieTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView{
    NSString *urlString=[self urlStringWithRefresh:refresh];
    [NetManager requestDataWithURLString:urlString finished:^(id responseObj) {
        NSDictionary *infoDict = responseObj[@"info"];
        self.maxid   = infoDict[@"maxid"];
        NSArray *listArray = responseObj[@"list"];
        NSArray *modelArray = [YZBudeJieTextModel mj_objectArrayWithKeyValuesArray:listArray];
        for (YZBudeJieTextModel *textModel in modelArray) {
            YZBuDeJieTextFrame *frame = [[YZBuDeJieTextFrame alloc] init];
            frame.textModel = textModel;
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
        return [NSString stringWithFormat:BuDeJieTextPushURL,self.maxid];
    }else{
        return BuDeJieTextUrl;
    }
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZBuDeJieTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZBuDeJieTextTableViewCell"];
    if (!cell) {
        cell = [[YZBuDeJieTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YZBuDeJieTextTableViewCell"];
    }
    [cell configure:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZBuDeJieTextFrame *frame = self.dataSource[indexPath.row];
    return frame.rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YZBuDeJieTextFrame *frame = self.dataSource[indexPath.row];
    YZBudeJieWebViewController *wvc = [[YZBudeJieWebViewController alloc] initWithUrlString:frame.textModel.weixin_url];
    [self.navigationController pushViewController:wvc animated:YES];
}
@end
