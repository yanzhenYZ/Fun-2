//
//  YZNetEaseViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZNetEaseViewController.h"
#import "YZNEWebViewController.h"
#import "YZNEPictureTableViewCell.h"
#import "YZNEPicturesTableViewCell.h"
#import "YZNetEaseModel.h"

@interface YZNetEaseViewController ()

@end

@implementation YZNetEaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self netEaseSuperRefresh];
    [self netRequestWithRefresh:RefreshType_NORMAL baseView:nil];
}

- (void)netEaseSuperRefresh
{
    //下拉无数据
    self.footer = [YZRefreshFooterView footer];
    self.footer.scrollView = self.tableView;
    YZWeakSelf(self)
    self.footer.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:RefreshType_PUSH baseView:baseView];
    };
}

- (NSString *)requestURLString:(RefreshType)refresh
{
    if (refresh == RefreshType_PUSH) {
        NSString *urlString=[self.pushURL stringByAppendingFormat:@"%lld",self.index++ * 20];
        return [urlString stringByAppendingString:NetEaseDefaultFooterURL];
    }else{
        return self.defaultURL;
    }
}

- (void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView
{
    NSString *urlString=[self requestURLString:refresh];
    [NetManager requestDataWithURLString:urlString finished:^(id responseObj) {
        NSArray *keyArray = responseObj[self.key];
        NSArray *models = [YZNetEaseModel mj_objectArrayWithKeyValuesArray:keyArray];
        for (YZNetEaseModel *model in models) {
            if (!model.url) continue;
            [self.dataSource addObject:model];
        }
        [baseView endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSString *error) {
        YZLog(@"ERROR:%@",error);
    }];
}

#pragma mark - tableView
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZNetEaseModel*model = self.dataSource[indexPath.row];
    if (model.imgextra.count == 2) {
        YZNEPicturesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZNEPicturesTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"YZNEPicturesTableViewCell" owner:self options:nil] lastObject];
        }
        [cell configure:model];
        return cell;
    }else{
        YZNEPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZNEPictureTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"YZNEPictureTableViewCell" owner:self options:nil] lastObject];
        }
        [cell configure:model];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZNetEaseModel *model=self.dataSource[indexPath.row];
    if (model.imgextra.count == 2) {
        return isIpad() ? 200 : 125;
    }else{
        return isIpad() ? 150 : 90;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZNetEaseModel *model = self.dataSource[indexPath.row];
    YZNEWebViewController *vc = [[YZNEWebViewController alloc] initWithUrlString:model.url_3w];
    NSLog(@"TTTT:%@",model.url_3w);
    [self.navigationController pushViewController:vc animated:YES];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url_3w] options:[NSDictionary new] completionHandler:nil];
}

@end
