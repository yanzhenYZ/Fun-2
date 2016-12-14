//
//  YZYKDBModel.h
//  Funny
//
//  Created by yanzhen on 16/12/14.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZYKDBModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *liveAddress;

- (instancetype)initWithName:(NSString *)name address:(NSString *)liveAddress;

@end
