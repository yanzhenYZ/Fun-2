//
//  YZSLiveModel.h
//  Funny
//
//  Created by yanzhen on 2017/4/11.
//  Copyright © 2017年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZSLiveModel : NSObject
@property (nonatomic) int fans;
@property (nonatomic) int follow;
@property (nonatomic) int ID;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) int regal_value;
@property (nonatomic, copy) NSString *region;
@property (nonatomic) int state;
@property (nonatomic) int type;
@property (nonatomic) int vharm_value;
@property (nonatomic, copy) NSString *video;
@property (nonatomic) int watch_count;
@property (nonatomic) int xing;
//
@property (nonatomic, readonly) NSString *imageURLStr;
@end
