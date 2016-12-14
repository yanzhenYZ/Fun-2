//
//  YZNVCModel.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZNVCModel : NSObject
/**           ViewController名称             */
@property (nonatomic, copy) NSString *vcName;
/**           ViewController标题             */
@property (nonatomic, copy) NSString *title;
/**           tabBar图片名称的前缀             */
@property (nonatomic, copy) NSString *imageHeader;
/**           其他                           */
@property (nonatomic, strong) NSArray <NSString *> *strings;
@end
