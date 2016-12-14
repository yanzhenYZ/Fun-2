//
//  YZPictureTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/11/29.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZPictureTableViewCell.h"

@implementation YZPictureTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *mainImageView = [[UIImageView alloc] init];
        mainImageView.clipsToBounds = YES;
        mainImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:mainImageView];
        mainImageView.userInteractionEnabled = YES;
        self.mainImageView = mainImageView;
        
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGestureAction:)];
        [self.mainImageView addGestureRecognizer:longGesture];
    }
    return self;
}

- (void)longGestureAction:(UILongPressGestureRecognizer *)longGesture{
    if (!_canSave) return;
    if (longGesture.state == UIGestureRecognizerStateBegan) {
        UIImageView *imageView=(UIImageView *)longGesture.view;
        [[GlobalManager shareManager] saveImage:imageView.image];
    }
}

@end
