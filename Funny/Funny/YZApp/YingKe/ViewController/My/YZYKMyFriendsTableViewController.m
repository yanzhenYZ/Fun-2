//
//  YZYKMyFriendsTableViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/13.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKMyFriendsTableViewController.h"
#import "YZYKPlayerViewController.h"
#import "YZYingKeModel.h"
#import "YZYKDBModel.h"
#import "YZDBManager.h"
#import "YZYingKeMacro.h"

@interface YZYKMyFriendsTableViewController ()
@property (nonatomic, strong) NSMutableArray <YZYKDBModel *>*dataSource;
@end

@implementation YZYKMyFriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的好友";
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    self.clearsSelectionOnViewWillAppear = NO;
    _dataSource = [YZDBManager allLive];
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YZYKMyFriendsTableViewController"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZYKMyFriendsTableViewController" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.row].name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YZYingKeModel *model = [[YZYingKeModel alloc] init];
    model.stream_addr = [NSString stringWithFormat:YK_Live_Header,self.dataSource[indexPath.row].liveAddress];
    NSLog(@"TTTT:%@",model.stream_addr);
    YZYKPlayerViewController *vc = [[YZYKPlayerViewController alloc] initWithYingKeModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [YZDBManager deleteLive:self.dataSource[indexPath.row]];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除好友";
}
@end
