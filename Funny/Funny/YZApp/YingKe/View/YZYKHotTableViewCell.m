//
//  YZYKHotTableViewCell.m
//  yingke
//
//  Created by yanzhen on 16/12/9.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKHotTableViewCell.h"
#import "YZYingKeModel.h"
#import "YZSLiveModel.h"
#import "YZYingKeMacro.h"

@interface YZYKHotTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *mainIV;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *onLineLabel;

@end

@implementation YZYKHotTableViewCell

- (void)configureYK:(YZYingKeModel *)model
{
    NSString *imageURL = model.creator.portrait;
    if (![imageURL hasPrefix:YK_ImageURL_Header]) {
        imageURL = [YK_ImageURL_Header stringByAppendingPathComponent:model.creator.portrait];
    }
    [_mainIV yz_setImageWithURL:imageURL placeholderImage:@"live_default"];
    [_headIV yz_setImageWithURL:imageURL placeholderImage:@"default_head"];
    _nickLabel.text = model.creator.nick;
    _addressLabel.text = model.city.length > 0 ? model.city : @"难道在火星";
    _onLineLabel.text = [NSString stringWithFormat:@"%ld",model.online_users];
}

- (void)configureSLive:(YZSLiveModel *)model
{
    [_mainIV yz_setImageWithURL:model.imageURLStr placeholderImage:@"live_default"];
    [_headIV yz_setImageWithURL:model.imageURLStr placeholderImage:@"default_head"];
    _nickLabel.text = model.name;
    _addressLabel.text = model.region > 0 ? model.region : @"难道在火星";
    _onLineLabel.text = [NSString stringWithFormat:@"%d",model.watch_count];
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
