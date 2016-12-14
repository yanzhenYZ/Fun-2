//
//  YZAboutManageTableViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZAboutManageTableViewController.h"
#import "YZManagePasswordViewController.h"

@interface YZAboutManageTableViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation YZAboutManageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = @[@[@"修改记事本密码",@"修改管理员密码"]];
    self.tableView.rowHeight = 50.0;
    self.tableView.sectionFooterHeight = 0.1;
    self.tableView.backgroundColor = YZColor(230, 230, 237);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MANAGERCELL"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataSource[section];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MANAGERCELL" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *array = self.dataSource[indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *titles = @[@"密码管理"];
    return titles[section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = YZColor(230, 230, 237);
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        YZManagePasswordViewController *vc = [[YZManagePasswordViewController alloc] initWithPasswordType:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
