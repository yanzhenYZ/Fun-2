//
//  YZVideoFrame.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZVideoFrame.h"

@implementation YZVideoFrame

-(CGRect)playBtnFrame{
    return CGRectMake(CGRectGetMaxX(_mainIVFrame) - 70, CGRectGetMaxY(_mainIVFrame) - 62, 70, 62);
}

-(CGRect)progressViewFrame{
    return CGRectMake(_mainIVFrame.origin.x, CGRectGetMaxY(_mainIVFrame), _mainIVFrame.size.width, 2);
}
@end
