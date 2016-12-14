//
//  YZNetEaseModel.h
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperFrame.h"

@class YZImgsrcModel;
@interface YZNetEaseModel : YZSuperModel
//url 源URL
/**            主标题                 */
@property (nonatomic, copy) NSString *title;
/**            副标题                 */
@property (nonatomic, copy) NSString *digest; //段子只需要这一个
/**            时间                   */
@property (nonatomic, copy) NSString *ptime;
/**            来源                   */
@property (nonatomic, copy) NSString *source;
/**            URL                   */
@property (nonatomic, copy) NSString *url;
/**            源URL                  */
@property (nonatomic, copy) NSString *url_3w;
/**            一张图片的地址           */
@property (nonatomic, copy) NSString *imgsrc;
/**            其他两张图片的地址       */
@property (nonatomic, strong) NSArray <YZImgsrcModel *>*imgextra;
@end

#pragma mark - YZImgsrcModel
@interface YZImgsrcModel : NSObject
@property (nonatomic, copy) NSString *imgsrc;
@end
