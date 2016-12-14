//
//  YZContentTextTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZContentTextTableViewCell.h"
#import "YZUserView.h"
#import "YZCommentView.h"
#import "YZContentTextFrame.h"

@interface YZContentTextTableViewCell ()
@property (nonatomic, weak) YZUserView *userView;
@property (nonatomic, weak) YZCommentView *commentView;
@end

@implementation YZContentTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        YZUserView *userView = [[YZUserView alloc] init];
        [self.contentView addSubview:userView];
        self.userView = userView;
        
        YZCommentView *commentView = [[YZCommentView alloc] init];
        [self.contentView addSubview:commentView];
        self.commentView = commentView;
    }
    return self;
}

-(void)setTextFrame:(YZContentTextFrame *)textFrame{
    _textFrame = textFrame;
    YZContentGroup *group = textFrame.contentModel.group;
    [self.userView headViewWithheadImageUrlString:group.user.avatar_url name:group.user.name time:group.create_time.longLongValue];
    self.userView.frame =  CGRectMake(CONTENTSPACE * 2, CONTENTSPACE, WIDTH - 4 * CONTENTSPACE, USERVIEWHEIGHT);
    self.mainTextLabel.frame = textFrame.mainLabelFrame;
    self.mainTextLabel.text = group.text;
    self.commentView.frame = textFrame.commentViewFrame;
    if (textFrame.contentModel.comments.count > 0) {
        YZContentUser *user = textFrame.contentModel.comments[0];
        self.commentView.user = user;
    }
    self.backView.frame = textFrame.backViewFrame;
}

@end
