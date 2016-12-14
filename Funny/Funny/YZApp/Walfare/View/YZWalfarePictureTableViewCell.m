//
//  YZWalfarePictureTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfarePictureTableViewCell.h"
#import "YZWalfareGirlFrame.h"

@interface YZWalfarePictureTableViewCell ()
@property (nonatomic, weak) UILabel *creatTimeLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@end

@implementation YZWalfarePictureTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *creatTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CONTENTSPACE * 2, CONTENTSPACE, 200.0 , 25.0)];
        creatTimeLabel.font = [UIFont systemFontOfSize:CREATTIMELABELFONT];
        [self.contentView addSubview:creatTimeLabel];
        self.creatTimeLabel = creatTimeLabel;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:USERTEXTMAINLABELFONT];
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        self.canSave = YES;
    }
    return self;
}

-(void)setGirlFrame:(YZWalfareGirlFrame *)girlFrame{
    _girlFrame = girlFrame;
    self.contentLabel.frame  = girlFrame.contentLabelFrame;
    self.mainImageView.frame = girlFrame.mainIVFrame;
    self.backView.frame      = girlFrame.backViewFrame;
    
    self.creatTimeLabel.text = [NSString dateWithTimeInterval:girlFrame.girlModel.update_time.longLongValue];
    self.contentLabel.text = girlFrame.girlModel.wbody;
    [self.mainImageView yz_setImageWithURL:girlFrame.girlModel.wpic_middle placeholderImage:@"Y&Z"];
}

@end
