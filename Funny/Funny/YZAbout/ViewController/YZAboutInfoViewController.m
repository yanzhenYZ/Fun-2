//
//  YZAboutInfoViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZAboutInfoViewController.h"
#import "YZClipImageViewController.h"
#import "YZTableHeaderView.h"

#define ABOUTHEADHEIGHT isIpad() ? 400 : 290

@interface YZAboutInfoViewController ()<YZTableHeaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) YZTableHeaderView *headView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation YZAboutInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamedWithFunny:@"clear"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamedWithFunny:@"clear"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = YZColor(247, 247, 247);
    _headView = [[YZTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, ABOUTHEADHEIGHT)];
    _headView.delegate = self;
    _headView.headImageView.image = [UIImage imageNamedWithHZW:@"Ais"];
    NSData *data = [NSData dataWithContentsOfFile:[self filePath]];
    if (data.length > 0) {
        _headView.headImageView.image = [UIImage imageWithData:data];
    }
    self.tableView.tableHeaderView = _headView;
    self.tableView.rowHeight = 63;
    self.dataSource = [[NSArray alloc] initWithObjects:@"清除缓存",@"设置",@"管理",@"声明",@"关于", nil];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 10, WIDTH, 50);
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn setTitleColor:YZColor(255, 133, 25) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}

- (void)exit{
    exit(0);
}

-(NSString *)fileSize{
    NSUInteger bytes = [GlobalManager getCacheSize];
    return [NSString stringWithFormat:@"%.2fMB",bytes / 1000 / 1000.0];
}

#pragma mark - Tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AboutCell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AboutCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row  == 0) {
        cell.detailTextLabel.textColor = YZColor(255, 133, 25);
        //-size很大---会阻塞线程
        cell.detailTextLabel.text = [self fileSize];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [GlobalManager clearCache:^{
            [self.tableView reloadData];
        }];
    }else{
        NSArray *vcs = @[@"YZSettingTableViewController",@"YZAboutManagerLockViewController",@"YZAboutDeclartionViewController",@"YZAboutVersionViewController"];
        UIViewController *vc = [[NSClassFromString(vcs[indexPath.row - 1]) alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self beginScroll:scrollView.contentOffset.y];
}

- (void)beginScroll:(CGFloat)offsetY{
    if (offsetY < 0) {
        CGFloat scale = 1 - offsetY / (isIpad() ? 400 : ABOUTHEADHEIGHT);
        self.headView.headImageView.transform = CGAffineTransformMakeScale(scale, scale);
        CGRect rect = self.headView.headImageView.frame;
        rect.origin.y = offsetY;
        self.headView.headImageView.frame = rect;
    }
}

#pragma mark -  YZTableHeaderViewDelegate
-(void)touchBeganToChangePhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (isIpad()) {
        [self maekHeaderImage:image];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        YZWeakSelf(self)
        YZClipImageViewController *vc = [[YZClipImageViewController alloc] initWithImage:image clipImage:^(UIImage *image) {
            //获得图片的宽高时正方形--使用时长方形，会有偏差
            [weakself maekHeaderImage:image];
        }];
        [picker pushViewController:vc animated:YES];
    }
    
}

- (void)maekHeaderImage:(UIImage *)image{
    self.headView.headImageView.image = image;
    NSData *data = UIImagePNGRepresentation(image);
    NSString *filePath = [DocumentsPath stringByAppendingPathComponent:@"AboutHeadImage"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [data writeToFile:[self filePath] atomically:NO];
}

- (NSString *)filePath{
    return [DocumentsPath stringByAppendingPathComponent:@"AboutHeadImage/image.data"];
}

@end
