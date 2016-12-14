//
//  YZNEPictureTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZNEPictureTableViewCell.h"
#import "YZNetEaseModel.h"

@interface YZNEPictureTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@end

@implementation YZNEPictureTableViewCell

-(void)setModel:(YZNetEaseModel *)model{
    _model = model;
    [_imageV yz_setImageWithURL:model.imgsrc placeholderImage:@"Y&Z"];
    _titleLab.text = model.title;
    _subTitleLab.text = model.digest;
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
