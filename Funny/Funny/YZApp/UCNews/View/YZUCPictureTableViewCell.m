//
//  YZUCPictureTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZUCPictureTableViewCell.h"
#import "YZUCNewsModel.h"

@interface YZUCPictureTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *bottomLab;

@end

@implementation YZUCPictureTableViewCell

-(void)setModel:(YZUCNewsModel *)model{
    _model = model;
    YZUCPictureModel *pictureModel = model.thumbnails[0];
    [_imageV yz_setImageWithURL:pictureModel.url placeholderImage:@"Y&Z"];
    _titleLab.text = model.title;
    
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
