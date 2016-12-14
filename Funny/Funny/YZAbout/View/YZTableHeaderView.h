//
//  YZTableHeaderView.h
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZTableHeaderViewDelegate <NSObject>

@optional
- (void)touchBeganToChangePhoto;

@end

@interface YZTableHeaderView : UIView
@property (nonatomic, strong, readonly) UIImageView *headImageView;
@property (nonatomic, weak) id<YZTableHeaderViewDelegate> delegate;

@end
