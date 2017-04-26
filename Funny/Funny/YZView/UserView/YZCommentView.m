//
//  YZCommentView.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZCommentView.h"
#import "YZContentUser.h"

#define OTHERUSERTEXTLABELFONT 17.0
@interface YZCommentView ()
@property (nonatomic, weak) UIImageView *headImageView;
@property (nonatomic, weak) UILabel *userNameLabel;
@property (nonatomic, weak) UILabel *userTextLabel;
@end

@implementation YZCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YZColor(246, 246, 256);
        self.clipsToBounds = YES;
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 37, 18)];
        tipLabel.backgroundColor = YZColor(251, 95, 136);
        tipLabel.textAlignment=NSTextAlignmentCenter;
        tipLabel.textColor=[UIColor whiteColor];
        tipLabel.font=[UIFont systemFontOfSize:12];
        tipLabel.text=@"神评论";
        [self addSubview:tipLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 25.0, 25.0, 25.0)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView corner];
        [self addSubview:imageView];
        self.headImageView = imageView;
        
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, imageView.y, 200.0, imageView.height)];
        userNameLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:userNameLabel];
        self.userNameLabel = userNameLabel;
        
        UILabel *userTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 50.0, WIDTH - 70.0, 0.0)];
        userTextLabel.numberOfLines = 0;
        userTextLabel.font = [UIFont systemFontOfSize:OTHERUSERTEXTLABELFONT];
        [self addSubview:userTextLabel];
        self.userTextLabel = userTextLabel;
    }
    return self;
}

-(void)setUser:(YZContentUser *)user{
    _user = user;
    [self.headImageView yz_setImageWithURL:user.avatar_url];
    self.userNameLabel.text = user.user_name;
    self.userTextLabel.text = user.text;
    self.userTextLabel.frame = CGRectMake(40.0, 55.0, WIDTH - 70, self.height - COMMENTVIEWSPACE);
}

@end
