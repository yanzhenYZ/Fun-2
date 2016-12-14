//
//  YZSuperWebViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperWebViewController.h"

@interface YZSuperWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, copy) NSString *urlString;
@end

@implementation YZSuperWebViewController

- (instancetype)initWithUrlString:(NSString *)urlString
{
    self = [super initWithNibName:@"YZSuperWebViewController" bundle:nil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _urlString = urlString;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"Y&Z";
    NSURL *url=[NSURL URLWithString:_urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark - WebView delegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取全部html
//    NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].outerHTML;"];
//    NSLog(@"TTTT:%@",html);
    // 利用webView执行JS
    if ([self jsString].length > 0) {
        [webView stringByEvaluatingJavaScriptFromString:[self jsString]];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showWebView];
    });
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self showWebView];
}

#pragma mark - super
- (NSString *)jsString{
    
    return @"";
}

- (void)showWebView{
    [_indicator stopAnimating];
    _webView.hidden = NO;
}
@end
