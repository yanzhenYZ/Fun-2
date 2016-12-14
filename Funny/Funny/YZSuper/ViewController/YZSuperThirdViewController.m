//
//  YZSuperThirdViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperThirdViewController.h"

@interface YZSuperThirdViewController ()

@end

@implementation YZSuperThirdViewController

-(void)dealloc{
    [self.footer free];
    [self.header free];
}

-(instancetype)init{
    self = [super initWithNibName:@"YZSuperThirdViewController" bundle:nil];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
@end
