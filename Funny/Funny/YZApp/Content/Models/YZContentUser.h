//
//  YZContentUser.h
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZContentUser : NSObject
/**             头像地址              */
@property (nonatomic, copy) NSString *avatar_url;
/**             发表用户名称              */
@property (nonatomic, copy) NSString *name;
/**             评论用户名称              */
@property (nonatomic, copy) NSString *user_name;
/**             用户发表的内容         */
@property (nonatomic, copy) NSString *text;
@end
