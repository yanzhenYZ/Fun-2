//
//  YZSuperTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZSuperTableViewCell.h"

@implementation YZSuperTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = YZColor(246, 246, 246);
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
    }
    return self;
}
@end
