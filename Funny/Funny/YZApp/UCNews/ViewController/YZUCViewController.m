//
//  YZUCViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZUCViewController.h"
#import "YZSuperWebViewController.h"
#import "YZUCPictureTableViewCell.h"
#import "YZUCPicturesTableViewCell.h"
#import "YZUCNewsModel.h"

static CGFloat const UCThreePictureRowHeight = 123;
static CGFloat const UCPictureRowHeight = 80.0;
static NSString *const YZUCPicturesCell = @"YZUCPicturesCell";
static NSString *const YZUCPictureCell = @"YZUCPictureCell";

@interface YZUCViewController ()

@end

@implementation YZUCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self refreshSuper];
    [self netRequestWithRefresh:RefreshType_NORMAL baseView:nil];
}

- (void)refreshSuper
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

- (NSString *)requestURLString:(RefreshType)refresh
{
    if (refresh == RefreshType_NORMAL) {
        NSString *urlString=[self.UCNewsHeadURL stringByAppendingString:@"0"];
        urlString=[urlString stringByAppendingString:self.UCNewsMiddleURL];
        long long currentTime=[NSString currentTime].longLongValue;
        urlString=[urlString stringByAppendingFormat:@"%lld",currentTime*1000];
        return [urlString stringByAppendingString:self.UCNewsFootURL];
    }else{
        long long currentTime=[NSString currentTime].longLongValue;
        NSString *urlString=[self.UCNewsHeadURL stringByAppendingFormat:@"%lld",currentTime*1000];
        urlString=[urlString stringByAppendingString:self.UCNewsMiddleURL];
        urlString=[urlString stringByAppendingFormat:@"%lld",currentTime*1000+35];
        return [urlString stringByAppendingString:self.UCNewsFootURL];
    }
}

- (void)netRequestWithRefresh:(RefreshType)refresh baseView:(YZRefreshBaseView *)baseView
{
    NSString *urlString=[self requestURLString:refresh];
    [NetManager requestDataWithURLString:urlString finished:^(id responseObj) {
        NSDictionary *dataDict     = responseObj[@"data"];
        NSDictionary *articlesDict = dataDict[@"articles"];
        NSMutableArray *models = [NSMutableArray array];
        for (NSString *key in articlesDict) {
            YZUCNewsModel *news = [YZUCNewsModel mj_objectWithKeyValues:articlesDict[key]];
            [models addObject:news];
        }
        
        if (refresh == RefreshType_PULL) {
            for (YZUCNewsModel *news in models) {
                if (news.thumbnails.count < 1) continue;
                [self.dataSource insertObject:news atIndex:0];
            }
        }else{
            for (YZUCNewsModel *news in models) {
                if (news.thumbnails.count < 1) continue;
                [self.dataSource addObject:news];
            }
        }
        [baseView endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSString *error) {
        YZLog(@"ERROR:%@",error);
    }];
}
#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZUCNewsModel *model = self.dataSource[indexPath.row];
    if (model.thumbnails.count == 3) {
        YZUCPicturesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:YZUCPicturesCell];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"YZUCPicturesTableViewCell" owner:self options:nil] lastObject];
        }
        cell.model = model;
        return cell;
    }else if (model.thumbnails.count == 1)
    {
        YZUCPictureTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:YZUCPictureCell];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"YZUCPictureTableViewCell" owner:self options:nil] lastObject];
        }
        cell.model = model;
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZUCNewsModel *model = self.dataSource[indexPath.row];
    CGFloat rowHeight = 0.0f;
    if (model.thumbnails.count == 3) {
        rowHeight = isIpad() ? 200 : UCThreePictureRowHeight;
    }else if(model.thumbnails.count == 1){
        rowHeight = isIpad() ? 150 : UCPictureRowHeight;
    }
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZUCNewsModel *model = self.dataSource[indexPath.row];
    YZSuperWebViewController *vc = [[YZSuperWebViewController alloc] initWithUrlString:model.url];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
