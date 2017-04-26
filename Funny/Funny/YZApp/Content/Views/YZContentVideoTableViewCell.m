//
//  YZContentVideoTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZContentVideoTableViewCell.h"
#import "YZUserView.h"
#import "YZCommentView.h"
#import "YZContentVideoFrame.h"

@interface YZContentVideoTableViewCell ()
@property (nonatomic, weak) YZUserView *userView;
@property (nonatomic, weak) YZCommentView *commentView;
@property (nonatomic, weak) UILabel *contentLabel;
@end
@implementation YZContentVideoTableViewCell
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
        
        YZCommentView *commentView = [[YZCommentView alloc] init];
        [self.contentView addSubview:commentView];
        self.commentView = commentView;
    }
    return self;
}

- (void)configure:(YZContentVideoFrame *)videoFrame{
    [self tableViewReload];
    self.shareURL   = videoFrame.contentModel.group.video_720p.url_list[0][@"url"];
    self.shareTitle = videoFrame.contentModel.group.text;
    
    YZContentGroup *group = videoFrame.contentModel.group;
    [self.userView headViewWithheadImageUrlString:group.user.avatar_url name:group.user.name time:group.create_time.longLongValue];
    self.contentLabel.text = group.text;
    [self.mainImageView yz_setImageWithURL:group.large_cover.url_list[0][@"url"]];
    
    self.userView.frame = CGRectMake(CONTENTSPACE * 2, CONTENTSPACE, WIDTH - 4 * CONTENTSPACE, USERVIEWHEIGHT);
    self.contentLabel.frame = videoFrame.contentLabelFrame;
    self.mainImageView.frame = videoFrame.mainIVFrame;
    self.playBtn.frame = videoFrame.playBtnFrame;
    self.progressView.frame = videoFrame.progressViewFrame;
    self.commentView.frame = videoFrame.commentViewFrame;
    if (videoFrame.contentModel.comments.count > 0) {
        YZContentUser *user = videoFrame.contentModel.comments[0];
        self.commentView.user = user;
    }
    
    self.backView.frame = videoFrame.backViewFrame;
}

@end
