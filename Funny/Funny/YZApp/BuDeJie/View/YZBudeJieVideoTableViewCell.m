//
//  YZBudeJieVideoTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZBudeJieVideoTableViewCell.h"
#import "YZBuDeJieVideoFrame.h"
#import "YZUserView.h"

@interface YZBudeJieVideoTableViewCell ()
@property (nonatomic, weak) YZUserView *userView;
@property (nonatomic, weak) UILabel *contentLabel;
@end

@implementation YZBudeJieVideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        YZUserView *userView = [[YZUserView alloc] initWithFrame:CGRectMake(CONTENTSPACE * 2, CONTENTSPACE, WIDTH - 2 * CONTENTSPACE, USERVIEWHEIGHT)];
        [self.contentView addSubview:userView];
        self.userView = userView;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:USERTEXTMAINLABELFONT];
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return self;
}


- (void)configure:(YZBuDeJieVideoFrame *)videoFrame{
    [self tableViewReload];
    self.shareURL   = videoFrame.videoModel.videouri;
    self.shareTitle = videoFrame.videoModel.text;
    YZBudeJieVideoModel *model = videoFrame.videoModel;
    [self.userView headViewWithheadImageUrlString:model.profile_image name:model.name timeString:model.create_time];
    self.contentLabel.text = model.text;
    self.contentLabel.frame = videoFrame.contentLabelFrame;
    self.mainImageView.frame = videoFrame.mainIVFrame;
    [self.mainImageView yz_setImageWithURL:model.bimageuri];
    self.playBtn.frame = videoFrame.playBtnFrame;
    self.progressView.frame = videoFrame.progressViewFrame;
    self.backView.frame = videoFrame.backViewFrame;
}

@end
