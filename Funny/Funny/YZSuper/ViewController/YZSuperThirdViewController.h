//
//  YZSuperThirdViewController.h
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperSecondViewController.h"
#import "NetManager.h"
#import "YZRefresh.h"

@interface YZSuperThirdViewController : YZSuperSecondViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) YZRefreshHeaderView *header;
@property (nonatomic, strong) YZRefreshFooterView *footer;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end
