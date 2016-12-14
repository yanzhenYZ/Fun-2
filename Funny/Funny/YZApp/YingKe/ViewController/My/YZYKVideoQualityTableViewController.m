//
//  YZYKVideoQualityTableViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/14.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKVideoQualityTableViewController.h"
#import "YZYKLiveAddress.h"

@interface YZYKVideoQualityTableViewController ()
@property (nonatomic, strong) NSArray <NSArray *>*dataSource;
@property (nonatomic, assign) NSUInteger videoQuality;

@end

@implementation YZYKVideoQualityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频质量";
    _dataSource = @[@[@"15帧-码率:500Kps",@"24帧-码率:800Kps",@"30帧-码率:800Kps"],@[@"15帧-码率:800Kps",@"24帧-码率:800Kps",@"30帧-码率:800Kps"],@[@"15帧-码率:1000Kps",@"24帧-码率:1200Kps",@"30帧-码率:1200Kps"]];
    _videoQuality = [YZYKLiveAddress getVideoQuality];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    
    self.tableView.backgroundColor = YZColor(230, 230, 237);
    self.tableView.rowHeight = 50.0;
    self.tableView.sectionFooterHeight = 25.0;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YZYKVideoQualityTableViewController"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    label.text = @"部分设备可能不支持其中一些格式";
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    self.tableView.tableFooterView = label;
}


- (void)saveAction{
    [YZYKLiveAddress saveVideoQuality:_videoQuality];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchAction:(UISwitch *)sw{
    _videoQuality = sw.tag - 100;
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZYKVideoQualityTableViewController" forIndexPath:indexPath];
    UISwitch *sw = [[UISwitch alloc] init];
    sw.tag = indexPath.section * 3 + indexPath.row + 100;
    [sw addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    sw.on = _videoQuality == indexPath.section * 3 + indexPath.row;
    cell.accessoryView = sw;
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _videoQuality  = indexPath.section * 3 + indexPath.row;
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *titles = @[@"360x640",@"540x960",@"720x1280"];
    return titles[section];
}

@end
