//
//  YZClipImageViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/20.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZClipImageViewController.h"
#import "YZClipImageMaskView.h"

typedef void(^ImageBlock)(UIImage *image);

@interface YZClipImageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YZClipImageMaskView *maskView;
@property (nonatomic, copy) ImageBlock block;
@end

@implementation YZClipImageViewController

- (instancetype)initWithImage:(UIImage *)image clipImage:(void (^)(UIImage *image))block{
    if (self = [super init]) {
        _image = image;
        _block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"选取照片";
    self.view.backgroundColor = [UIColor blackColor];
    //用来截图的view--不可以使用scrollView
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
    _backView.center = CGPointMake(WIDTH * 0.5, HEIGHT * 0.5);
//    _backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_backView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:_backView.bounds];
    _scrollView.clipsToBounds = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.maximumZoomScale = 5;
    //=1.0时没有弹性的效果
    _scrollView.minimumZoomScale = 1.01;
    _scrollView.delegate = self;
    [self.backView addSubview:_scrollView];
    
    
    CGFloat imageW = _image.size.width;
    CGFloat imageH = _image.size.height;
    CGFloat scale  = WIDTH / imageW;
    imageW *= scale;
    imageH *= scale;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageW, imageH)];
    _imageView.image = _image;
    [_scrollView addSubview:_imageView];
    [_scrollView setZoomScale:1.01 animated:YES];
    
#warning mark - imageView坐标必须以(0, 0)开始(保证拖动imageView可以回到scrollView边界内)
    //调整imageView在scrollView的中心，只能通过设置--contentOffset
    _scrollView.contentOffset = CGPointMake((_imageView.width - _scrollView.width) * 0.5, (_imageView.height - _scrollView.height) * 0.5);
    _maskView = [[YZClipImageMaskView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) clipFrame:_backView.frame];
    [self.view addSubview:_maskView];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"使用" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
}

#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)saveAction{
    UIImage *image = [UIImage imageWithCaptureView:self.backView];
    if (_block) {
        _block(image);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
