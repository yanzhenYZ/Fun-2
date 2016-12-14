//
//  YZWhatSomeGroup.h
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZContentUser.h"

@class YZWhatSomeMiddle_image;
@interface YZWhatSomeGroup : NSObject
@property (nonatomic, strong) YZContentUser *user;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, strong) NSNumber *create_time;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) YZWhatSomeMiddle_image *middle_image;
@end

#pragma mark - YZWhatSomeLarge_image
@interface YZWhatSomeMiddle_image : NSObject
@property (nonatomic, strong) NSNumber *r_height;
@property (nonatomic, strong) NSNumber *r_width;
@property (nonatomic, strong) NSArray <NSDictionary *>*url_list;
//
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;
@end
