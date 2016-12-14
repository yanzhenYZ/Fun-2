//
//  YZDBManager.h
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YZNoteModel;
@class YZYKDBModel;
@interface YZDBManager : NSObject
+ (void)addNote:(YZNoteModel *)model;
+ (void)deleteNote:(YZNoteModel *)model;
+ (void)updateNote:(YZNoteModel *)model;
+ (NSMutableArray <YZNoteModel *>*)allNote;
//live
+ (void)addLive:(YZYKDBModel *)model;
+ (void)deleteLive:(YZYKDBModel *)model;
+ (void)updateLive:(YZYKDBModel *)model;
+ (NSMutableArray <YZYKDBModel *>*)allLive;
@end
