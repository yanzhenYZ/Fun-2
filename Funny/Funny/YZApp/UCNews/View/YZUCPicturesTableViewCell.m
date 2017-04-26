//
//  YZUCPicturesTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZUCPicturesTableViewCell.h"
#import "YZUCNewsModel.h"

@interface YZUCPicturesTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *leftIV;
@property (weak, nonatomic) IBOutlet UIImageView *middleIV;
@property (weak, nonatomic) IBOutlet UIImageView *rightIV;
@property (weak, nonatomic) IBOutlet UILabel *bottomLab;

@end

@implementation YZUCPicturesTableViewCell

- (void)configure:(YZUCNewsModel *)model{
    _titleLab.text = model.title;
    //
    YZUCPictureModel *pictureModel = model.thumbnails[0];
    YZUCPictureModel *pictureModel1 = model.thumbnails[1];
    YZUCPictureModel *pictureModel2 = model.thumbnails[2];
    [_leftIV yz_setImageWithURL:pictureModel.url];
    [_middleIV yz_setImageWithURL:pictureModel1.url];
    [_rightIV yz_setImageWithURL:pictureModel2.url];
    //
    long long time = model.publish_time.longLongValue / 1000;
    NSString *bottomString = [NSString dateWithTimeInterval:time];
    bottomString = [bottomString stringByAppendingString:@"    "];
    bottomString = [bottomString stringByAppendingString:model.origin_src_name];
    _bottomLab.text = bottomString;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
