//
//  YZYKHotTableViewController.m
//  yingke
//
//  Created by yanzhen on 16/12/8.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKHotTableViewController.h"
#import "YZHomeViewController.h"
#import "YZYKPlayerViewController.h"
#import "YZYKHotTableViewCell.h"
#import "YZRefreshHeaderView.h"
#import "YZYingKeModel.h"
#import "YZYingKeMacro.h"
#import "NetManager.h"

@interface YZYKHotTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) YZRefreshHeaderView *header;
@property (nonatomic, weak) YZHomeViewController *homeVC;
@end

@implementation YZYKHotTableViewController
-(void)dealloc{
    [_header free];
}

-(YZHomeViewController *)homeVC{
    if (!_homeVC) {
        _homeVC = (YZHomeViewController *)self.parentViewController;
    }
    return _homeVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    self.tableView.rowHeight = isIpad() ? 644 : 420;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"YZYKHotTableViewCell" bundle:nil] forCellReuseIdentifier:@"YZYKHotTableViewCell"];
    
    _header = [YZRefreshHeaderView  header];
    _header.scrollView = self.tableView;
    YZWeakSelf(self)
    _header.beginRefreshingBlock = ^(YZRefreshBaseView *baseView){
        [weakself reloadData];
    };
    
    [self reloadData];
}

- (void)reloadData{
    [NetManager requestDataWithURLString:YK_Hot_URL finished:^(id responseObj) {
        NSArray *lives = responseObj[@"lives"];
        NSArray *models = [YZYingKeModel mj_objectArrayWithKeyValuesArray:lives];
        if (models.count > 0) {
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:models];
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
    YZYingKeModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YZYKPlayerViewController *vc = [[YZYKPlayerViewController alloc] initWithYingKeModel:self.dataSource[indexPath.row]];
    vc.hidesBottomBarWhenPushed = YES;
    [_homeVC push];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - scrollView
#pragma mark - navgationBar和tabBar滑动隐藏
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y < 0) return;
    [self.homeVC childVCDidEndDragging:scrollView.contentOffset.y];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (scrollView.contentOffset.y < 0) return;
    [self.homeVC childVCDidScroll:offsetY isHot:YES];
}
@end
