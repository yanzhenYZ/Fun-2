//
//  YZSettingTableViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSettingTableViewController.h"
#import "YZFunnyCrashViewController.h"

@interface YZSettingTableViewController ()
@property (strong, nonatomic) NSArray *dataSource;
@end

@implementation YZSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.rowHeight = 50;
    self.tableView.sectionFooterHeight = 25.0;
    self.tableView.backgroundColor = YZColor(230, 230, 237);
    UIView *tableHeaderView = [[UIView alloc] init];
    tableHeaderView.height = 25.0;
    tableHeaderView.backgroundColor = YZColor(230, 230, 237);
    self.tableView.tableHeaderView = tableHeaderView;
    _dataSource = @[@[@"隐私设置"],@[@"Crash Log"]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataSource[section];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SETTINGS_CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SETTINGS_CELL"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *items = self.dataSource[indexPath.section];
    cell.textLabel.text = items[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = YZColor(230, 230, 237);
    return view;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    }else if (1 == indexPath.section) {
        YZFunnyCrashViewController *vc = [[YZFunnyCrashViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
