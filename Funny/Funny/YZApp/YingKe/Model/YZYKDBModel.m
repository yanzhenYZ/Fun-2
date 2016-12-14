//
//  YZYKDBModel.m
//  Funny
//
//  Created by yanzhen on 16/12/14.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKDBModel.h"

@implementation YZYKDBModel
- (instancetype)initWithName:(NSString *)name address:(NSString *)liveAddress{
    if (self = [super init]) {
        self.name = name;
        self.liveAddress = liveAddress;
    }
    return self;
}
@end
