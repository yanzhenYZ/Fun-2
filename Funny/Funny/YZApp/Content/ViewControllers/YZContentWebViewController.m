//
//  YZContentWebViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZContentWebViewController.h"

@interface YZContentWebViewController ()

@end

@implementation YZContentWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)jsString{
    NSMutableString *js = [NSMutableString string];
    //删除顶部和底部的bar
    //main-container
    [js appendString:@"var openNow = document.getElementsByClassName('banner-warpper')[0];"];
    [js appendString:@"var openNow1 = document.getElementsByClassName('banner-warpper')[1];"];
    
    [js appendString:@"var topBar = openNow.parentNode;"];
    [js appendString:@"topBar.parentNode.removeChild(topBar);"];
    
    [js appendString:@"var bottomBar = openNow1.parentNode;"];
    [js appendString:@"bottomBar.parentNode.removeChild(bottomBar);"];
    
    
    //more-comment
    [js appendString:@"var yzMCClass = document.getElementsByClassName('more-comment')[0];"];
    [js appendString:@"var yzMCClassParent = yzMCClass.parentNode;"];
    [js appendString:@"yzMCClassParent.parentNode.removeChild(yzMCClassParent);"];
    return js;
}


/**
 [js appendString:@"var openNow = document.getElementsByClassName('open download J-download J-app-download-link')[0];"];
 [js appendString:@"var openNow1 = document.getElementsByClassName('open download J-download J-app-download-link')[1];"];
 
 [js appendString:@"var topBar = openNow.parentNode;"];
 [js appendString:@"topBar.parentNode.removeChild(topBar);"];
 
 [js appendString:@"var bottomBar = openNow1.parentNode;"];
 [js appendString:@"bottomBar.parentNode.removeChild(bottomBar);"];
 */

@end
