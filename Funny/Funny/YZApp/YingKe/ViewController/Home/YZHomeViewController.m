//
//  YZHomeViewController.m
//  yingke
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZHomeViewController.h"
#import "YZYKNearCollectionViewController.h"
#import "YZYKHotTableViewController.h"
#import "YZYKHomeTopView.h"
#import "YZLocationManager.h"
#import "YZYingKeMacro.h"

@interface YZHomeViewController ()<UIScrollViewDelegate,YZYKHomeTopViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YZYKHotTableViewController *hotVC;
@property (nonatomic, strong) YZYKNearCollectionViewController *nearVC;
@property (nonatomic, strong) YZYKHomeTopView *topView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat hot_offsetY;
@property (nonatomic, assign) CGFloat near_offsetY;

@property (nonatomic, assign) BOOL up;

@end

@implementation YZHomeViewController

-(void)dealloc{
    [_timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view layoutIfNeeded];
#warning mark - scrollView手动加载不会出现--navigationBar--tabBar留下白色边框的问题--
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self.view insertSubview:self.scrollView atIndex:0];
    //1;
    _hotVC  = [[YZYKHotTableViewController alloc] init];
    [self addChildViewController:_hotVC];
    _hotVC.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [self.scrollView addSubview:_hotVC.view];
    //2--只有滚动到附近页面才去加载
    _nearVC = [[YZYKNearCollectionViewController alloc] init];
    [self addChildViewController:_nearVC];
    
    self.scrollView.contentSize = CGSizeMake(WIDTH * 2, 0);
    
    _topView = [[YZYKHomeTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    _topView.delegate = self;
    self.navigationItem.titleView = _topView;
    
    YZWeakSelf(self)
    _timer = [NSTimer timerWithTimeInterval:130.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakself reloadData];
    }];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    YZLocationManager *manager = [[YZLocationManager alloc] init];
    [manager startUpdatingLocation];
}

- (void)reloadData{
    [_hotVC reloadData];
    if ([_nearVC isViewLoaded]) {
        [_nearVC reloadData];
    }
}

- (void)push{
    UIEdgeInsets inset = self.scrollView.contentInset;
    inset.top = 64;
    self.scrollView.contentInset = inset;
}

- (void)childVCDidEndDragging:(CGFloat)offsetY{
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    __block UIEdgeInsets inset = self.scrollView.contentInset;
    void (^IdentityBlock)() = ^(){
        [UIView animateWithDuration:0.25 animations:^{
            tabBar.y = HEIGHT - 49;
            navigationBar.y = 20;
            inset.top = navigationBar.y + 44;
            self.scrollView.contentInset = inset;
        }];
    };
    
    void (^HiddenBlock)() = ^(){
        [UIView animateWithDuration:0.25 animations:^{
            tabBar.y = HEIGHT + 39;
            navigationBar.y = -44;
            inset.top = navigationBar.y + 44;
            self.scrollView.contentInset = inset;
        }];
    };
    
    if (_up) {
        if (tabBar.y >= HEIGHT - 19) {
            HiddenBlock();
        }else{
            IdentityBlock();
        }
    }else{
        if (tabBar.y <= HEIGHT - 19) {
            IdentityBlock();
        }else{
            HiddenBlock();
        }
    }
}

- (void)childVCDidScroll:(CGFloat)offsetY isHot:(BOOL)hot{
    CGFloat space =  hot ?  _hot_offsetY - offsetY : _near_offsetY - offsetY;
    UITabBar *tabBar = self.tabBarController.tabBar;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    CGFloat maxY = hot ? _hot_offsetY : _near_offsetY;
    if (offsetY > maxY) {
        //⬆️
        _up = YES;
        if (navigationBar.y <= 20) {
            UIEdgeInsets inset = self.scrollView.contentInset;
            if (navigationBar.y + space < -44) {
                navigationBar.y = -44;
            }else{
                navigationBar.y += space;
            }
            inset.top = navigationBar.y + 44;
            self.scrollView.contentInset = inset;
        }
        
        if (tabBar.y >= HEIGHT - 49) {
            if (tabBar.y - space > HEIGHT + 39) {
                tabBar.y = HEIGHT + 39;
            }else{
                tabBar.y -= space;
            }
        }
    }else{
        //⤵️
        _up = NO;
        if (navigationBar.y < 20) {
            UIEdgeInsets inset = self.scrollView.contentInset;
            if (navigationBar.y + space >= 20) {
                navigationBar.y = 20;
            }else{
                navigationBar.y += space;
            }
            inset.top = navigationBar.y + 44;
            self.scrollView.contentInset = inset;
        }
        
        if (tabBar.y > HEIGHT - 49) {
            if (tabBar.y - space < HEIGHT - 49) {
                tabBar.y = HEIGHT - 49;
            }else{
                tabBar.y -= space;
            }
        }
    }
    if (hot) {
        _hot_offsetY = offsetY;
    }else{
        _near_offsetY = offsetY;
    }
}

#pragma mark - YZYKHomeTopViewDelegate
-(void)homeTopViewClick:(HomeTopViewBtnType)type{
    CGPoint offset = CGPointMake((type - HomeTopViewBtnType_Hot) * WIDTH, self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //点击topView-btn会调用
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / WIDTH;
    [self.topView scroll:index + HomeTopViewBtnType_Hot];
    
    UIViewController * childVC = self.childViewControllers[index];
    if ([childVC isViewLoaded] || index != 1) return;
    childVC.view.frame = CGRectMake(WIDTH * index, 0, WIDTH, HEIGHT);
    [self.scrollView addSubview:childVC.view];
}


@end
