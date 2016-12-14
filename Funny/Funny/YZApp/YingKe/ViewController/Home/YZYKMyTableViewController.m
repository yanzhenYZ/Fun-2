//
//  YZYKMyTableViewController.m
//  yingke
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKMyTableViewController.h"
#import "YZQRScanningViewController.h"

@interface YZYKMyTableViewController ()
@property (nonatomic, strong) NSMutableArray <NSArray *>*dataSource;
@end

@implementation YZYKMyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.tableView.rowHeight = 50;
    self.tableView.sectionFooterHeight = 25.0;
    self.tableView.backgroundColor = YZColor(230, 230, 237);
    
    _dataSource = [[NSMutableArray alloc] init];
    NSArray *array = @[@[@"我的直播地址",@"我的好友"],@[@"扫一扫"],@[@"视频质量",@"美颜设置"],@[@"声明"],@[@"退出"]];
    [_dataSource addObjectsFromArray:array];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKABOUT"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YKABOUT"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = YZColor(230, 230, 237);
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray <NSArray *>*vcs = @[@[@"YZYKMyLiveAddressViewController",@"YZYKMyFriendsTableViewController"],@[@"YZYKMyLiveAddressViewController"],@[@"YZYKVideoQualityTableViewController",@"YZYKBeautyViewController"],@[@"YZYKDeclarationViewController"],@[@"EXIT"]];
    NSString *className = vcs[indexPath.section][indexPath.row];
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    if (indexPath.section == 1 && indexPath.row == 0) {
        vc = [[YZQRScanningViewController alloc] initWithLive:YES];
    }else if (indexPath.section == 4){
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
