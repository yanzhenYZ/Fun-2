//
//  YZBudeJieWebViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/2.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZBudeJieWebViewController.h"

@interface YZBudeJieWebViewController ()

@end

@implementation YZBudeJieWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSString *)jsString{
    //g-mn1
    NSMutableString *js = [NSMutableString string];
    
    if (isIpad()) {
        [js appendString:@"var topBar = document.getElementsByClassName('nav-new')[0];"];
        [js appendString:@"topBar.parentNode.removeChild(topBar);"];
    }else{
        //bar bar-header
        [js appendString:@"var topBar = document.getElementsByClassName('bar bar-header')[0];"];
        [js appendString:@"topBar.parentNode.removeChild(topBar);"];
    }
    
    return js;
}

@end
