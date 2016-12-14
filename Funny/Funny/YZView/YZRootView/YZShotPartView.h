//
//  YZShotPartView.h
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZShotPartViewDelegate <NSObject>

- (void)shotPart:(BOOL)shot frme:(CGRect)rect;

@end

@interface YZShotPartView : UIView
@property (nonatomic, weak) id<YZShotPartViewDelegate>delegate;
@end
