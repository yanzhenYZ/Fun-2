//
//  YZNEWebViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZNEWebViewController.h"

@interface YZNEWebViewController ()

@end

@implementation YZNEWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSString *)jsString{
    NSMutableString *js = [NSMutableString string];
    
    
    if (isIpad()) {
        //header
        [js appendString:@"var yzHeader = document.getElementsByClassName('header')[0];"];
        [js appendString:@"yzHeader.parentNode.removeChild(yzHeader);"];
        
        //侧面
        [js appendString:@"var yzAside = document.getElementsByClassName('aside')[0];"];
        [js appendString:@"yzAside.parentNode.removeChild(yzAside);"];
        
//        [js appendString:@"var yzBottom = document.getElementsByClassName('aside')[0];"];
//        [js appendString:@"yzBottom.parentNode.removeChild(yzBottom);"];
    }else{
        // 删除顶部
        [js appendString:@"var yzTopbar = document.getElementsByClassName('topbar')[0];"];
        [js appendString:@"yzTopbar.parentNode.removeChild(yzTopbar);"];
        // 删除广告
        [js appendString:@"var box = document.getElementsByClassName('a_adtemp a_topad js-topad')[0];"];
        [js appendString:@"box.parentNode.removeChild(box);"];
        //
        [js appendString:@"var buyNow = document.getElementsByClassName('more_client more-client')[0];"];
        [js appendString:@"buyNow.parentNode.removeChild(buyNow);"];
        //广告
        [js appendString:@"var yzTB = document.getElementsByClassName('a_adtemp a_tbad js-tbad')[0];"];
        [js appendString:@"yzTB.parentNode.removeChild(yzTB);"];
    }
    
    return js;
}

@end
