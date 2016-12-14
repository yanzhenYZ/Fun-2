//
//  YZBuDeJieTextFrame.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZBuDeJieTextFrame.h"

@implementation YZBuDeJieTextFrame
-(void)setTextModel:(YZBudeJieTextModel *)textModel{
    _textModel = textModel;
    CGSize size = [[GlobalManager shareManager] labelSize:textModel.text font:USERTEXTMAINLABELFONT width:WIDTH - CONTENTSPACE * 4];
    _mainLabelFrame = CGRectMake(CONTENTSPACE * 2, USERVIEWHEIGHT, WIDTH - 4 * CONTENTSPACE, size.height);
    self.backViewFrame = CGRectMake(CONTENTSPACE, CONTENTSPACE, WIDTH - 2 * CONTENTSPACE, CGRectGetMaxY(_mainLabelFrame) + 5);
    self.rowHeight = CGRectGetMaxY(self.backViewFrame);
}
@end

#pragma mark - YZBudeJieTextModel
@implementation YZBudeJieTextModel

@end
