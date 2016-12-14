//
//  YZYKNearCollectionViewCell.m
//  yingke
//
//  Created by yanzhen on 16/12/9.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZYKNearCollectionViewCell.h"
#import "YZYingKeModel.h"
#import "YZYingKeMacro.h"

@interface YZYKNearCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *mainIV;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation YZYKNearCollectionViewCell

-(void)setModel:(YZYingKeModel *)model{
    _model = model;
    NSString *imageURL = model.creator.portrait;
    if (![imageURL hasPrefix:YK_ImageURL_Header]) {
        imageURL = [YK_ImageURL_Header stringByAppendingPathComponent:model.creator.portrait];
    }
    [_mainIV yz_setImageWithURL:imageURL placeholderImage:@"live_default"];
    if (model.distance.length > 0) {
        _addressLabel.text = [NSString stringWithFormat:@"距您--%@",model.distance];
    }else{
        _addressLabel.text = model.city.length > 0 ? model.city : @"火星";
    }
}

- (void)showAnimation{
    if (self.model.isShow) return;
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.transform = CATransform3DIdentity;
        CATransform3DMakeScale(1, 1, 1);
        self.model.show = YES;
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
