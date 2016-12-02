//
//  TMXReplyBottomView.m
//  TMX3DPrinter
//
//  Created by kobe on 16/9/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXReplyBottomView.h"

@interface TMXReplyBottomView ()<UITextFieldDelegate>
@property (nonatomic, strong) KBTextField *replyTextField;
@property (nonatomic, strong) UIButton *replyButton;
@end

@implementation TMXReplyBottomView

-(KBTextField *)replyTextField{
    
    if (!_replyTextField) {
        _replyTextField=[KBTextField new];
        _replyTextField.backgroundColor=[UIColor whiteColor];
        _replyTextField.delegate=self;
        _replyTextField.font = [UIFont systemFontOfSize:12*AppScale];
        _replyTextField.layer.cornerRadius = 5*AppScale;
        _replyTextField.layer.masksToBounds = YES;
        _replyTextField.layer.borderColor = systemColor.CGColor;
        _replyTextField.layer.borderWidth = 1;
    }
    return _replyTextField;
}

-(UIButton *)replyButton{
    
    if (!_replyButton) {
        _replyButton=[UIButton buttonWithType:0];
        _replyButton.backgroundColor=systemColor;
        _replyButton.layer.cornerRadius=5.0;
        _replyButton.layer.masksToBounds=YES;
        _replyButton.titleLabel.font = [UIFont systemFontOfSize:13*AppScale];
        NSString *_reply = NSLocalizedString(@"Reply", nil);
        [_replyButton setTitle:_reply forState:0];
        [_replyButton setTitleColor:[UIColor whiteColor] forState:0];
        [_replyButton addTarget:self action:@selector(replyBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyButton;
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{

    [self addSubview:self.replyTextField];
    [self addSubview:self.replyButton];
    [self updateConstraints];
}


-(void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    [_replyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(@(30*AppScale));
        make.right.equalTo(_replyButton.mas_left).with.offset(-10*AppScale);
    }];
    
    [_replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 30*AppScale));
    }];
}

#pragma mark <otherResponse>
-(void)replyBtn:(UIButton *)btn{
    
    [_replyTextField resignFirstResponder];
    if (_replyTextField.text.length!=0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(replyContent:textField:)]) {
            [self.delegate replyContent:_replyTextField.text textField:_replyTextField];
        }
    }else{
        [MBProgressHUD showError:NSLocalizedString(@"Comment_content", nil)];
    }
}

#pragma mark <getter setter>
-(void)setPlaceholderContent:(NSString *)placeholderContent{
    
    _placeholderContent=placeholderContent;
//    NSString *reply = NSLocalizedString(@"Reply", nil);
    _replyTextField.placeholder=[NSString stringWithFormat:@"%@",placeholderContent];
}

-(void)setIsFirstResponse:(BOOL)isFirstResponse{
    
    if (isFirstResponse) {
        [_replyTextField becomeFirstResponder];
    }
}

@end
