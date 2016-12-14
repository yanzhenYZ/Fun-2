
//
//  YZWalfareGirlFrame.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfareGirlFrame.h"

@implementation YZWalfareGirlFrame
-(void)setGirlModel:(YZWalfareGirlModel *)girlModel{
    _girlModel = girlModel;
    CGFloat viewWidth = WIDTH - CONTENTSPACE * 4;
    CGRect rect = CGRectMake(CONTENTSPACE * 2, 25 + CONTENTSPACE, viewWidth, 0);
    if (girlModel.wbody.length > 1) {
        CGSize size = [[GlobalManager shareManager] labelSize:girlModel.wbody font:USERTEXTMAINLABELFONT width:WIDTH - 20];
        rect.size.height = size.height + 5;
    }
    _contentLabelFrame = rect;
    
    CGFloat originW = girlModel.wpic_m_width.longLongValue ? girlModel.wpic_m_height.longLongValue : 1;
    CGFloat originH = girlModel.wpic_m_height.longLongValue;
    CGFloat scale   = viewWidth / originW;
    originH *= scale;
    _mainIVFrame = CGRectMake(CONTENTSPACE * 2, CGRectGetMaxY(rect), viewWidth, originH);
    self.backViewFrame = CGRectMake(CONTENTSPACE, CONTENTSPACE, WIDTH - 2 * CONTENTSPACE, CGRectGetMaxY(_mainIVFrame));
    self.rowHeight = CGRectGetMaxY(self.backViewFrame);
}
@end

#pragma mark - YZWalfareGirlModel
@implementation YZWalfareGirlModel

@end
