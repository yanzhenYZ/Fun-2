//
//  YZNoteCollectionViewCell.h
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZNoteCollectionViewCell;
@protocol YZNoteCollectionViewCellDelegate <NSObject>

- (void)deleteNote:(YZNoteCollectionViewCell *)cell;

@end

@class YZNoteModel;
@interface YZNoteCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) YZNoteModel *model;
@property (nonatomic, assign) BOOL deleteBtnHidden;
@property (nonatomic, weak) id<YZNoteCollectionViewCellDelegate>delegate;

- (void)animation;

@end
