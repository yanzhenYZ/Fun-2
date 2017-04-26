//
//  YZYKNearCollectionViewController.m
//  yingke
//
//  Created by yanzhen on 16/12/9.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKNearCollectionViewController.h"
#import "YZHomeViewController.h"
#import "YZYKPlayerViewController.h"
#import "YZYKNearCollectionViewCell.h"
#import "YZRefreshHeaderView.h"
#import "YZYingKeModel.h"
#import "YZLocationManager.h"
#import "NetManager.h"
#import "YZYingKeMacro.h"

@interface YZYKNearCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (nonatomic, strong) YZRefreshHeaderView *header;
@property (nonatomic, weak) YZHomeViewController *homeVC;
@end

@implementation YZYKNearCollectionViewController

static NSString * const reuseIdentifier = @"YZYKNearCollectionViewCell";

-(void)dealloc{
    [_header free];
}

-(YZHomeViewController *)homeVC{
    if (!_homeVC) {
        _homeVC = (YZHomeViewController *)self.parentViewController;
    }
    return _homeVC;
}

//必须-在初始化的时候给他一个---布局
-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    CGFloat itemW = (WIDTH - 20) / 3;
    layout.itemSize = CGSizeMake(itemW, itemW * 1.25);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    self.collectionView.backgroundColor = YZColor(235, 246, 252);
    [self.collectionView registerNib:[UINib nibWithNibName:@"YZYKNearCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    _header = [YZRefreshHeaderView  header];
    _header.scrollView = self.collectionView;
    YZWeakSelf(self)
    _header.beginRefreshingBlock = ^(YZRefreshBaseView *baseView){
        [weakself reloadData];
    };

    
    [self reloadData];
}
- (void)reloadData{
    __block NSString *urlString = YK_Near_URL;
    [[YZLocationManager shareManager] getLocationCoordinate2D:^(BOOL locationServicesEnabled, NSString *latitude, NSString *longitude) {
        //不能定位locationServicesEnabled = YES
        if (!locationServicesEnabled) {
            //latitude=longitude=0也会有数据
            urlString = [NSString stringWithFormat:YK_Near_AppendingURL,latitude,longitude];
        }
    }];
    
    [NetManager requestDataWithURLString:urlString finished:^(id responseObj) {
        NSArray *lives = responseObj[@"lives"];
        NSArray *models = [YZYingKeModel mj_objectArrayWithKeyValuesArray:lives];
        if (models.count > 0) {
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:models];
        }
        [self.header endRefreshing];
        [self.collectionView reloadData];
    } failed:^(NSString *error) {
        NSLog(@"Error:%@",error);
        [self.header endRefreshing];
    }];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YZYKNearCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.item];
    
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    YZYKNearCollectionViewCell *ykCell = (YZYKNearCollectionViewCell *)cell;
    [ykCell showAnimation];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YZYingKeModel *model = self.dataSource[indexPath.row];
    YZYKPlayerViewController *vc = [[YZYKPlayerViewController alloc] initWithStream_addr:model.stream_addr img:model.creator.portrait];
    vc.hidesBottomBarWhenPushed = YES;
    [_homeVC push];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - scrollView
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y < 0) return;
    [self.homeVC childVCDidEndDragging:scrollView.contentOffset.y];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (scrollView.contentOffset.y < 0) return;
    [self.homeVC childVCDidScroll:offsetY isHot:NO];
}
@end
