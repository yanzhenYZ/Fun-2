//
//  YZContentTextFrame.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZContentTextFrame.h"

@implementation YZContentTextFrame
-(void)setContentModel:(YZContentModel *)contentModel{
    _contentModel = contentModel;
    YZContentGroup *group = contentModel.group;
    CGSize size = [[GlobalManager shareManager] labelSize:group.text font:USERTEXTMAINLABELFONT width:WIDTH - 20];
    _mainLabelFrame = CGRectMake(CONTENTSPACE * 2, USERVIEWHEIGHT, WIDTH - 4 * CONTENTSPACE, size.height);
    _commentViewFrame = CGRectMake(CONTENTSPACE * 2, CGRectGetMaxY(_mainLabelFrame) + CONTENTSPACE, WIDTH - 4 * CONTENTSPACE, 0);
    if (contentModel.comments.count > 0) {
        YZContentUser *user = contentModel.comments[0];
        CGSize size = [[GlobalManager shareManager] labelSize:user.text font:OTHERUSERTEXTLABELFONT width:WIDTH - 70];
        _commentViewFrame.size.height = size.height + COMMENTVIEWSPACE;
    }
    self.backViewFrame = CGRectMake(CONTENTSPACE, CONTENTSPACE, WIDTH - CONTENTSPACE * 2, CGRectGetMaxY(_commentViewFrame));
    self.rowHeight = CGRectGetMaxY(self.backViewFrame);
}
@end
