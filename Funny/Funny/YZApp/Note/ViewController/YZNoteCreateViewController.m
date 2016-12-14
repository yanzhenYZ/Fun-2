//
//  YZNoteCreateViewController.m
//  Funny
//
//  Created by yanzhen on 16/12/6.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZNoteCreateViewController.h"
#import "Toast+UIView.h"
#import "YZNoteModel.h"
#import "YZDBManager.h"

@interface YZNoteCreateViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textBottomConstraint;
@property (nonatomic, strong) YZNoteModel *noteModel;
@end

@implementation YZNoteCreateViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithNoteModel:(YZNoteModel *)noteModel{
    self = [super init];
    if (self) {
        _noteModel = noteModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"笔记";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonClick)];
    if (_noteModel) {
        self.textView.text = _noteModel.title;
    }
    [self.textView becomeFirstResponder];
    
    YZWeakSelf(self)
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [weakself keyboardChange:keyboardFrame];
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [weakself keyboardChange:keyboardFrame];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [weakself keyboardChange:keyboardFrame];
    }];
}

- (void)keyboardChange:(CGRect)rect{
    [UIView animateWithDuration:0.25 animations:^{
        self.textBottomConstraint.constant = HEIGHT - rect.origin.y;
    }];
}
- (void)saveButtonClick
{
    if (self.textView.text.length <= 0) {
        [self.view makeCenterToast:@"内容为空,请重新输入"];
        return;
    }
    if (_noteModel) {
        if (![_noteModel.title isEqualToString:_textView.text]) {
            _noteModel.title = _textView.text;
            [YZDBManager updateNote:_noteModel];
        }
    }else{
        YZNoteModel *note= [[YZNoteModel alloc] initWithTitle:self.textView.text time:[[NSDate date] timeIntervalSince1970]];
        [YZDBManager addNote:note];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
