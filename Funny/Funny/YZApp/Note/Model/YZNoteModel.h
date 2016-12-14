//
//  YZNoteModel.h
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"

@interface YZNoteModel : YZSuperModel

- (instancetype)initWithTitle:(NSString *)title time:(long long)time;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) long long time;
@property (nonatomic, assign) BOOL animated;

@end
