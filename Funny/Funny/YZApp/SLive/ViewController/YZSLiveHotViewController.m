//
//  YZSLiveHotViewController.m
//  Funny
//
//  Created by yanzhen on 2017/4/11.
//  Copyright © 2017年 v2tech. All rights reserved.
//

#import "YZSLiveHotViewController.h"
#import "YZYKPlayerViewController.h"
#import "YZYKHotTableViewCell.h"
#import "YZRefreshHeaderView.h"
#import "YZSLiveModel.h"
#import "NetManager.h"

@interface YZSLiveHotViewController ()

@end

@implementation YZSLiveHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"sLive";
    self.dataSource = [[NSMutableArray alloc] init];
    self.tableView.rowHeight = isIpad() ? 644 : 420;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"YZYKHotTableViewCell" bundle:nil] forCellReuseIdentifier:@"YZYKHotTableViewCell"];
    
    self.header = [YZRefreshHeaderView  header];
    self.header.scrollView = self.tableView;
    YZWeakSelf(self)
    self.header.beginRefreshingBlock = ^(YZRefreshBaseView *baseView){
        [weakself reloadData];
    };
    
    [self reloadData];

}

- (void)reloadData{
    [NetManager requestDataWithURLString:@"http://a.zzrunmeng.com/online/direcset.do" finished:^(id responseObj) {
        NSArray *hotArray = responseObj[@"hot"];
        NSArray<YZSLiveModel *> *lives = [YZSLiveModel mj_objectArrayWithKeyValuesArray:hotArray];
        if (lives.count > 0) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:lives];
        }
        [self.header endRefreshing];
        [self.tableView reloadData];
    } failed:^(NSString *error) {
        NSLog(@"ERROR:%@",error);
        [self.header endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZYKHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZYKHotTableViewCell" forIndexPath:indexPath];
    YZSLiveModel *model = self.dataSource[indexPath.row];
    [cell configureSLive:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YZSLiveModel *model = self.dataSource[indexPath.row];
    NSLog(@"TTTT:%@",model.video);
    YZYKPlayerViewController *vc = [[YZYKPlayerViewController alloc] initWithStream_addr:model.video img:model.imageURLStr];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
