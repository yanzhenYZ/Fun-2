//
//  YZWhatSomeTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWhatSomeTableViewCell.h"
#import "YZWhatSomeFrame.h"
#import "YZUserView.h"

@interface YZWhatSomeTableViewCell ()
@property (nonatomic, weak) YZUserView *userView;
@property (nonatomic, weak) UILabel *contentLabel;
@end

@implementation YZWhatSomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        YZUserView *userView = [[YZUserView alloc] init];
        [self.contentView addSubview:userView];
        self.userView = userView;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:USERTEXTMAINLABELFONT];
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        self.canSave = YES;
    }
    return self;
}

- (void)configure:(YZWhatSomeFrame *)pictureFrame{
    YZWhatSomeGroup *group = pictureFrame.model.group;
    [self.userView headViewWithheadImageUrlString:group.user.avatar_url name:group.user.name time:group.create_time.longLongValue];
    self.contentLabel.text = group.text;
    [self.mainImageView yz_setImageWithURL:group.middle_image.url_list[0][@"url"]];
    
    self.userView.frame = CGRectMake(CONTENTSPACE * 2, CONTENTSPACE, WIDTH - 4 * CONTENTSPACE, USERVIEWHEIGHT);
    self.contentLabel.frame = pictureFrame.contentLabelFrame;
    self.mainImageView.frame = pictureFrame.mainIVFrame;
    self.backView.frame = pictureFrame.backViewFrame;
}

@end
