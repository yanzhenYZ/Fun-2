//
//  YZUserView.m
//  Funny
//
//  Created by yanzhen on 16/11/28.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZUserView.h"

@interface YZUserView ()
@property (nonatomic, weak) UIImageView *headImageView;
@property (nonatomic, weak) UILabel *userNameLabel;
@property (nonatomic, weak) UILabel *creatTimeLabel;
@end

@implementation YZUserView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CONTENTSPACE, 50.0, 50.0)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView corner];
        [self addSubview:imageView];
        self.headImageView = imageView;
        
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + CONTENTSPACE, CONTENTSPACE * 1.5, 200.0, 20.0)];
        userNameLabel.font = [UIFont systemFontOfSize:USERNAMELABELFONT];
        [self addSubview:userNameLabel];
        self.userNameLabel = userNameLabel;
        
        UILabel *creatTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameLabel.x, userNameLabel.maxY + CONTENTSPACE / 2, 200.0, 20.0)];
        creatTimeLabel.font = [UIFont systemFontOfSize:CREATTIMELABELFONT];
        [self addSubview:creatTimeLabel];
        self.creatTimeLabel = creatTimeLabel;
    }
    return self;
}

-(void)headViewWithheadImageUrlString:(NSString *)headImageUrlString name:(NSString *)name time:(long long)time{
    [self headViewWithheadImageUrlString:headImageUrlString name:name timeString:[NSString dateWithTimeInterval:time]];
}

- (void)headViewWithheadImageUrlString:(NSString *)headImageUrlString name:(NSString *)name timeString:(NSString *)time{
    [self.headImageView yz_setImageWithURL:headImageUrlString placeholderImage:@"Y&Z"];
    self.userNameLabel.text = name;
    self.creatTimeLabel.text = time;
}
@end
