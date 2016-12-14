//
//  YZSuperWebViewController.h
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZSuperWebViewController : UIViewController<UIWebViewDelegate>
- (instancetype)initWithUrlString:(NSString *)urlString;
- (NSString *)jsString;
@end
