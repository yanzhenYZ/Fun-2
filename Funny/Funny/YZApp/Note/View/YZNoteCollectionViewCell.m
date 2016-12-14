//
//  YZNoteCollectionViewCell.m
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZNoteCollectionViewCell.h"
#import "YZNoteModel.h"

@interface YZNoteCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation YZNoteCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(YZNoteModel *)model{
    _model = model;
    self.textView.text = model.title;
    self.titleLab.text = [NSString dateWithTimeInterval:model.time];
}

-(void)animation{
    if (self.model.animated) return;
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:1 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.model.animated = YES;
    }];
}

-(void)setDeleteBtnHidden:(BOOL)deleteBtnHidden{
    _deleteBtnHidden = deleteBtnHidden;
    _deleteBtn.hidden = deleteBtnHidden;
}

- (IBAction)deleteBtnClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(deleteNote:)]) {
        [_delegate deleteNote:self];
    }
}

@end
