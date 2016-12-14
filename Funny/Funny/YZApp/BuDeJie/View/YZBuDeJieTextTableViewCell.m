//
//  YZBuDeJieTextTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZBuDeJieTextTableViewCell.h"
#import "YZBuDeJieTextFrame.h"
#import "YZUserView.h"

@interface YZBuDeJieTextTableViewCell ()
@property (nonatomic, weak) YZUserView *userView;
@end

@implementation YZBuDeJieTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        YZUserView *userView = [[YZUserView alloc] initWithFrame:CGRectMake(CONTENTSPACE * 2, CONTENTSPACE, WIDTH - 2 * CONTENTSPACE, USERVIEWHEIGHT)];
        [self.contentView addSubview:userView];
        self.userView = userView;
    }
    return self;
}


-(void)setTextFrame:(YZBuDeJieTextFrame *)textFrame{
    _textFrame = textFrame;
    YZBudeJieTextModel *model = textFrame.textModel;
    [self.userView headViewWithheadImageUrlString:model.profile_image name:model.name timeString:model.create_time];
    self.mainTextLabel.text = model.text;
    self.mainTextLabel.frame = textFrame.mainLabelFrame;
    self.backView.frame = textFrame.backViewFrame;
}

@end
