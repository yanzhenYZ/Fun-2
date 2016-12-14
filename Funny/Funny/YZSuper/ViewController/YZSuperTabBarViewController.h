//
//  YZSuperTabBarViewController.h
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZSuperTabBarViewController : UITabBarController

-(UINavigationController *)nvcWithVCName:(NSString *)vcName title:(NSString *)title imageNameHeader:(NSString *)imageNameHeader;

@end
