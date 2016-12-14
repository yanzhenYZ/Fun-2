//
//  YZNoteViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/5.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZNoteViewController.h"
#import "YZNoteCreateViewController.h"
#import "YZNoteCollectionViewCell.h"
#import "YZNoteModel.h"
#import "YZDBManager.h"

@interface YZNoteViewController ()<YZNoteCollectionViewCellDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <YZNoteModel *>*dataSource;
@end

@implementation YZNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"笔记管理";
    self.automaticallyAdjustsScrollViewInsets = YES;
    _dataSource = [[NSMutableArray alloc] init];
    [_collectionView registerNib:[UINib nibWithNibName:@"YZNoteCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"YZNoteCollectionViewCell"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editBtnClick)];
}

- (void)editBtnClick{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"编辑"]) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
    }else{
        self.navigationItem.rightBarButtonItem.title = @"编辑";
    }
    [self.collectionView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData{
    //暴力刷新--(增加，修改)--可以改进
    [_dataSource removeAllObjects];
    [_dataSource addObjectsFromArray:[YZDBManager allNote]];
    [_collectionView reloadData];
}

- (IBAction)addNote:(id)sender {
    YZNoteCreateViewController *vc = [[YZNoteCreateViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - collectionView dataSourec
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YZNoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YZNoteCollectionViewCell" forIndexPath:indexPath];
    YZNoteModel *model = self.dataSource[indexPath.item];
    cell.model = model;
    cell.delegate = self;
    cell.deleteBtnHidden = [self.navigationItem.rightBarButtonItem.title isEqualToString:@"编辑"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (![self.navigationItem.rightBarButtonItem.title isEqualToString:@"编辑"]) return;
    YZNoteModel *note = self.dataSource[indexPath.item];
    YZNoteCreateViewController *vc = [[YZNoteCreateViewController alloc] initWithNoteModel:note];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - 15) * 0.5, isIpad() ? 220 : 170);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    YZNoteCollectionViewCell *noteCell = (YZNoteCollectionViewCell *)cell;
    [noteCell animation];
}

#pragma mark - YZNoteCollectionViewCellDelegate
-(void)deleteNote:(YZNoteCollectionViewCell *)cell{
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    YZNoteModel *note = self.dataSource[indexPath.item];
    [YZDBManager deleteNote:note];
    [self.dataSource removeObject:note];
    [self.collectionView reloadData];
}

@end
