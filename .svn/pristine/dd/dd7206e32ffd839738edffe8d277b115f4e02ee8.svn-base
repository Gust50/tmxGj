//
//  TMXFeedbackBottomView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXFeedbackBottomView.h"

@interface TMXFeedbackBottomView ()
@property (nonatomic, strong)KBTextField *inputContent;
@property (nonatomic, strong)UIButton *feedBackBtn;
@end
@implementation TMXFeedbackBottomView

-(KBTextField *)inputContent
{
    if (!_inputContent) {
        _inputContent = [[KBTextField alloc] init];
        _inputContent.layer.cornerRadius = 5*AppScale;
        _inputContent.layer.masksToBounds = YES;
        _inputContent.layer.borderColor = systemColor.CGColor;
        _inputContent.layer.borderWidth = 1;
//        _inputContent.placeholder = @"请输入反馈内容";
        _inputContent.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _inputContent;
}

-(UIButton *)feedBackBtn
{
    if (!_feedBackBtn) {
        _feedBackBtn = [[UIButton alloc] init];
        _feedBackBtn.layer.cornerRadius = 5*AppScale;
        _feedBackBtn.layer.masksToBounds = YES;
        _feedBackBtn.backgroundColor = systemColor;
        _feedBackBtn.titleLabel.font = [UIFont systemFontOfSize:13*AppScale];
//        [_feedBackBtn setTitle:@"反馈" forState:UIControlStateNormal];
        [_feedBackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_feedBackBtn addTarget:self action:@selector(feedback) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feedBackBtn;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.inputContent];
    [self addSubview:self.feedBackBtn];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_feedBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 30*AppScale));
    }];
    
    [_inputContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_feedBackBtn.mas_left).offset(-10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(@(30*AppScale));
    }];
}

//反馈
- (void)feedback
{
    [_inputContent resignFirstResponder];
    if (_inputContent.text.length!=0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(TMXFeedbackBottomView:textField:)]) {
            [self.delegate TMXFeedbackBottomView:self.inputContent.text textField:_inputContent];
        }
    }else
    {
        [MBProgressHUD showError:NSLocalizedString(@"InFeedback", nil)];
    }
}

#pragma mark - setter getter
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _inputContent.placeholder = placeholder;
}

-(void)setBtnContent:(NSString *)btnContent
{
    _btnContent = btnContent;
    [_feedBackBtn setTitle:btnContent forState:UIControlStateNormal];
}

@end
