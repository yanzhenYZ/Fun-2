//
//  YZContentVideoFrame.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZContentVideoFrame.h"

@implementation YZContentVideoFrame
-(void)setContentModel:(YZContentModel *)contentModel{
    _contentModel = contentModel;
    YZContentGroup *group = contentModel.group;
    
    CGFloat viewWidth = WIDTH - CONTENTSPACE * 4;
    //label默认上下会有边距
    CGRect rect = CGRectMake(CONTENTSPACE * 2, USERVIEWHEIGHT, viewWidth, CONTENTSPACE);
    if (group.text.length > 0) {
        CGSize size = [[GlobalManager shareManager] labelSize:group.text font:USERTEXTMAINLABELFONT width:WIDTH - 20];
        rect.size.height = size.height + 5;
    }
    _contentLabelFrame = rect;
    //
    CGFloat originW = group.video_720p.width.longLongValue ? group.video_720p.width.longLongValue : 1;
    CGFloat originH = group.video_720p.height.longLongValue;
    CGFloat scale   = viewWidth / originW;
    originH *= scale;
    self.mainIVFrame = CGRectMake(CONTENTSPACE * 2, CGRectGetMaxY(rect), viewWidth, originH);
    //
    _commentViewFrame = CGRectMake(CONTENTSPACE * 2, CGRectGetMaxY(self.mainIVFrame) + CONTENTSPACE + 2, viewWidth, 0);
    if (contentModel.comments.count > 0) {
        YZContentUser *user = contentModel.comments[0];
        CGSize size = [[GlobalManager shareManager] labelSize:user.text font:OTHERUSERTEXTLABELFONT width:WIDTH - 70];
        _commentViewFrame.size.height = size.height + COMMENTVIEWSPACE;
    }
    self.backViewFrame = CGRectMake(CONTENTSPACE, CONTENTSPACE, WIDTH - CONTENTSPACE * 2, CGRectGetMaxY(_commentViewFrame));
    self.rowHeight = CGRectGetMaxY(self.backViewFrame);
}

@end

