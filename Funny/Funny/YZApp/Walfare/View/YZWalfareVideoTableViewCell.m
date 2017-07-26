//
//  YZWalfareVideoTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfareVideoTableViewCell.h"
#import "YZWalfareVideoFrame.h"

@interface YZWalfareVideoTableViewCell ()
@property (nonatomic, weak) UILabel *creatTimeLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@end

@implementation YZWalfareVideoTableViewCell

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
        
        self.mainImageView.videoGravity = YZAVVideoGravityResize;
    }
    return self;
}

- (void)configure:(YZWalfareVideoFrame *)videoFrame{
    [self tableViewReload];
    self.shareURL   = videoFrame.videoModel.vplay_url;
    self.shareTitle = videoFrame.videoModel.wbody;
    self.contentLabel.frame  = videoFrame.contentLabelFrame;
    self.videoViewFrame      = videoFrame.mainIVFrame;
    self.backView.frame      = videoFrame.backViewFrame;
    
    self.creatTimeLabel.text = [NSString dateWithTimeInterval:videoFrame.videoModel.update_time.longLongValue];
    self.contentLabel.text = videoFrame.videoModel.wbody;
    [self.mainImageView yz_setImageWithURL:videoFrame.videoModel.vpic_small];
    
}

@end
