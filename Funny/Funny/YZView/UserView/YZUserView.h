//
//  YZUserView.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZUserView : UIView
- (void)headViewWithheadImageUrlString:(NSString *)headImageUrlString name:(NSString *)name time:(long long)time;
- (void)headViewWithheadImageUrlString:(NSString *)headImageUrlString name:(NSString *)name timeString:(NSString *)time;
@end
