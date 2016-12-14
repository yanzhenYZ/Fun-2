//
//  YZWalfareVideoFrame.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfareVideoFrame.h"

@implementation YZWalfareVideoFrame
-(void)setVideoModel:(YZWalfareVideoModel *)videoModel{
    _videoModel = videoModel;
    CGFloat viewWidth = WIDTH - CONTENTSPACE * 4;
    //label默认上下会有边距
    CGRect rect = CGRectMake(CONTENTSPACE * 2, CONTENTSPACE + 25, viewWidth, CONTENTSPACE);
    if (videoModel.wbody.length > 0) {
        CGSize size = [[GlobalManager shareManager] labelSize:videoModel.wbody font:USERTEXTMAINLABELFONT width:WIDTH - 20];
        rect.size.height = size.height + 5;
    }
    _contentLabelFrame = rect;
    CGFloat maxY = CGRectGetMaxY(_contentLabelFrame);
    self.mainIVFrame = CGRectMake(CONTENTSPACE * 2, maxY + CONTENTSPACE, viewWidth, viewWidth * 3 / 4);
    self.backViewFrame = CGRectMake(CONTENTSPACE, CONTENTSPACE, WIDTH - 2 * CONTENTSPACE, CGRectGetMaxY(self.mainIVFrame) + CONTENTSPACE + 2);
    self.rowHeight = CGRectGetMaxY(self.backViewFrame);
}
@end

#pragma mark - YZWalfareVideoModel
@implementation YZWalfareVideoModel

@end
