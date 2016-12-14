//
//  YZNoteModel.m
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZNoteModel.h"

@implementation YZNoteModel

-(instancetype)initWithTitle:(NSString *)title time:(long long)time{
    self = [super init];
    if (self) {
        self.title = title;
        self.time = time;
    }
    return self;
}

@end
