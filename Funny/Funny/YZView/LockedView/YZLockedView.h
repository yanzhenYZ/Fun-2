//
//  YZLockedView.h
//  Funny
//
//  Created by yanzhen on 16/12/5.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^PasswordBlock)(NSString *password);
@interface YZLockedView : UIView
@property (nonatomic, copy) PasswordBlock block;
@end
