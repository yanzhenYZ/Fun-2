//
//  YZManagePasswordViewController.h
//  Funny
//
//  Created by yanzhen on 16/12/7.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PasswordType) {
    PasswordType_Note,
    PasswordType_Manager
};

@interface YZManagePasswordViewController : UIViewController
- (instancetype)initWithPasswordType:(PasswordType)type;
@end
