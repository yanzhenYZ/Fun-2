//
//  YZBuDeJieVideoFrame.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZBuDeJieVideoFrame.h"

@implementation YZBuDeJieVideoFrame
-(void)setVideoModel:(YZBudeJieVideoModel *)videoModel{
    _videoModel = videoModel;
    CGFloat viewWidth = WIDTH - CONTENTSPACE * 4;
    //label默认上下会有边距
    CGRect rect = CGRectMake(CONTENTSPACE * 2, USERVIEWHEIGHT, viewWidth, CONTENTSPACE);
    if (videoModel.text.length > 0) {
        CGSize size = [[GlobalManager shareManager] labelSize:videoModel.text font:USERTEXTMAINLABELFONT width:WIDTH - 20];
        rect.size.height = size.height + 5;
    }
    _contentLabelFrame = rect;
    CGFloat height = 0.0f;
    CGFloat scale  = videoModel.width.integerValue  / viewWidth;
    height         = videoModel.height.integerValue / scale;
    self.mainIVFrame = CGRectMake(CONTENTSPACE * 2, CGRectGetMaxY(_contentLabelFrame), viewWidth, height);
    self.backViewFrame = CGRectMake(CONTENTSPACE, CONTENTSPACE, WIDTH - CONTENTSPACE * 2, CGRectGetMaxY(self.mainIVFrame) + CONTENTSPACE + 2);
    self.rowHeight = CGRectGetMaxY(self.backViewFrame);
    
}

@end

#pragma mark - YZBudeJieVideoModel
@implementation YZBudeJieVideoModel

@end
