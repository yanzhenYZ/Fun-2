//
//  YZTextTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZTextTableViewCell.h"

@implementation YZTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *mainTextLabel = [[UILabel alloc] init];
        mainTextLabel.font = [UIFont systemFontOfSize:USERTEXTMAINLABELFONT];
        mainTextLabel.numberOfLines = 0;
        [self.contentView addSubview:mainTextLabel];
        self.mainTextLabel = mainTextLabel;
    }
    return self;
}


@end
