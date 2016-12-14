//
//  YZWalfareTextFrame.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfareTextFrame.h"

@implementation YZWalfareTextFrame
-(void)setTextModel:(YZWalfareTextModel *)textModel{
    _textModel = textModel;
    CGSize size = [[GlobalManager shareManager] labelSize:textModel.wbody font:USERTEXTMAINLABELFONT width:WIDTH - CONTENTSPACE * 4];
    _mainLabelFrame    = CGRectMake(CONTENTSPACE * 2, 25 + CONTENTSPACE, WIDTH - 4 * CONTENTSPACE, size.height);
    self.backViewFrame = CGRectMake(CONTENTSPACE, CONTENTSPACE, WIDTH - 2 * CONTENTSPACE, CGRectGetMaxY(_mainLabelFrame) + 5);
    self.rowHeight     = CGRectGetMaxY(self.backViewFrame);
}
@end

#pragma mark - YZWalfareTextModel
@implementation YZWalfareTextModel

@end
