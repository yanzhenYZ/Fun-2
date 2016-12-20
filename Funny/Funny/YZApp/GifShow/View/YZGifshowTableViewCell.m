//
//  YZGifshowTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZGifshowTableViewCell.h"
#import "YZGifshowModel.h"
#import "YZUserView.h"

@interface YZGifshowTableViewCell ()
@property (nonatomic, weak) YZUserView *userView;
@end

@implementation YZGifshowTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        YZUserView *userView = [[YZUserView alloc] initWithFrame:CGRectMake(CONTENTSPACE * 2, CONTENTSPACE, WIDTH - 2 * CONTENTSPACE, USERVIEWHEIGHT)];
        [self.contentView addSubview:userView];
        self.userView = userView;
    }
    return self;
}

-(void)setModel:(YZGifshowModel *)model{
    _model = model;
    self.shareURL = model.main_mv_url;
    [self.userView headViewWithheadImageUrlString:model.headurl name:model.user_name time:[model.time timeStringToLongLong]];
    [self.mainImageView yz_setImageWithURL:model.thumbnail_url placeholderImage:@"Y&Z"];
    CGFloat mainHeight = (WIDTH - 100) / 3 * 4;
    self.mainImageView.frame = CGRectMake(50, 70.0, WIDTH - 100.0, mainHeight);
    self.progressView.frame = CGRectMake(self.mainImageView.x, self.mainImageView.maxY, WIDTH - 100, 2);
    self.playBtn.frame = CGRectMake(self.mainImageView.maxX - 70, self.mainImageView.maxY - 62, 70, 62);
    self.backView.frame = CGRectMake(CONTENTSPACE, CONTENTSPACE, WIDTH - 2 * CONTENTSPACE, self.mainImageView.maxY + 7);
}

@end