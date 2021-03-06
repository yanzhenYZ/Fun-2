//
//  YZNEPicturesTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/12/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZNEPicturesTableViewCell.h"
#import "YZNetEaseModel.h"

@interface YZNEPicturesTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *leftIV;
@property (weak, nonatomic) IBOutlet UIImageView *middleIV;
@property (weak, nonatomic) IBOutlet UIImageView *rightIV;

@end

@implementation YZNEPicturesTableViewCell

- (void)configure:(YZNetEaseModel *)model{
    _titleLab.text = model.title;
    [_leftIV yz_setImageWithURL:model.imgsrc];
    YZImgsrcModel *imgsrc = model.imgextra[0];
    [_middleIV yz_setImageWithURL:imgsrc.imgsrc];
    imgsrc = model.imgextra[1];
    [_rightIV yz_setImageWithURL:imgsrc.imgsrc];
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
