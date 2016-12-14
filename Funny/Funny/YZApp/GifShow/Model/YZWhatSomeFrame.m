//
//  YZWhatSomeFrame.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWhatSomeFrame.h"

@implementation YZWhatSomeFrame
-(void)setModel:(YZWhatSomeModel *)model{
    _model = model;
    YZWhatSomeGroup *group = model.group;
    CGFloat viewWidth = WIDTH - CONTENTSPACE * 4;
    CGRect rect = CGRectMake(CONTENTSPACE * 2, 60.0, viewWidth, CONTENTSPACE);
    if (group.text.length > 0) {
        CGSize size = [[GlobalManager shareManager] labelSize:group.text font:USERTEXTMAINLABELFONT width:WIDTH - 20];
        rect.size.height = size.height + 5;
    }
    _contentLabelFrame = rect;

    CGFloat originW = group.middle_image.r_width.longLongValue ? group.middle_image.r_height.longLongValue : 1;
    CGFloat originH = group.middle_image.r_height.longLongValue;
    CGFloat scale   = viewWidth / originW;
    originH *= scale;
    _mainIVFrame = CGRectMake(CONTENTSPACE * 2, CGRectGetMaxY(rect), viewWidth, originH);
    self.backViewFrame = CGRectMake(CONTENTSPACE, CONTENTSPACE, WIDTH - 2 * CONTENTSPACE, CGRectGetMaxY(_mainIVFrame));
    self.rowHeight = CGRectGetMaxY(self.backViewFrame);
}
@end

#pragma mark - YZWhatSomeModel
@implementation YZWhatSomeModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"comments" : @"YZContentUser"
             };
}
@end
