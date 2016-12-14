//
//  YZWalfareTextTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/30.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZWalfareTextTableViewCell.h"
#import "YZWalfareTextFrame.h"

@interface YZWalfareTextTableViewCell ()
@property (nonatomic, weak) UILabel *creatTimeLabel;
@end

@implementation YZWalfareTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *creatTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CONTENTSPACE * 2, CONTENTSPACE, 200.0 , 25.0)];
        creatTimeLabel.font = [UIFont systemFontOfSize:CREATTIMELABELFONT];
        [self.contentView addSubview:creatTimeLabel];
        self.creatTimeLabel = creatTimeLabel;
    }
    return self;
}

-(void)setTextFrame:(YZWalfareTextFrame *)textFrame{
    _textFrame = textFrame;
    self.mainTextLabel.frame = textFrame.mainLabelFrame;
    self.backView.frame = textFrame.backViewFrame;
    
    self.creatTimeLabel.text = [NSString dateWithTimeInterval:textFrame.textModel.update_time.longLongValue];
    self.mainTextLabel.text = textFrame.textModel.wbody;
}

@end
