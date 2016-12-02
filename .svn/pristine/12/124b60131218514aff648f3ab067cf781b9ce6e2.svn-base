//
//  TMXHomeDetailShareView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeDetailShareView.h"

@interface TMXHomeDetailShareView ()
@property (nonatomic, strong)UIImageView *backView;
@property (nonatomic, strong)UILabel *line;
@property (nonatomic, strong)UIButton *modelShare;
@property (nonatomic, strong)UIButton *caseShare;
@end
@implementation TMXHomeDetailShareView
#pragma mark - lazyLoad
-(UIImageView *)backView
{
    if (!_backView) {
        _backView = [[UIImageView alloc] init];
        _backView.image = [UIImage imageNamed:@"ShareBackView"];
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

-(UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGBColor(220, 220, 220);
    }
    return _line;
}

-(UIButton *)modelShare
{
    if (!_modelShare) {
        _modelShare = [[UIButton alloc] init];
        _modelShare.titleLabel.font = [UIFont systemFontOfSize:11*AppScale];
        [_modelShare setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _modelShare.titleEdgeInsets = UIEdgeInsetsMake(0, 15*AppScale, 0, 0);
        [_modelShare setTitle:NSLocalizedString(@"Model_share", nil) forState:UIControlStateNormal];
        [_modelShare setImage:[UIImage imageNamed:@"ModelShare"] forState:UIControlStateNormal];
        [_modelShare addTarget:self action:@selector(modelShareEven) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modelShare;
}

-(UIButton *)caseShare
{
    if (!_caseShare) {
        _caseShare = [[UIButton alloc] init];
        _caseShare.titleLabel.font = [UIFont systemFontOfSize:11*AppScale];
        [_caseShare setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _caseShare.titleEdgeInsets = UIEdgeInsetsMake(0, 15*AppScale, 0, 0);
        [_caseShare setTitle:NSLocalizedString(@"Case_share", nil) forState:UIControlStateNormal];
        [_caseShare setImage:[UIImage imageNamed:@"CaseShare"] forState:UIControlStateNormal];
        [_caseShare addTarget:self action:@selector(caseShareEven) forControlEvents:UIControlEventTouchUpInside];
    }
    return _caseShare;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = RGBAColor(0, 0, 0, 0.3);
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
        [self addGestureRecognizer:gesture];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.backView];
    [self.backView addSubview:self.line];
    [self.backView addSubview:self.modelShare];
    [self.backView addSubview:self.caseShare];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-5*AppScale);
        make.top.equalTo(weakSelf.mas_top).offset(64);
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 70*AppScale));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView.mas_right);
        make.left.equalTo(_backView.mas_left);
        make.centerY.equalTo(_backView.mas_centerY);
        make.height.mas_equalTo(@(1));
    }];
    
    [_modelShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView.mas_right);
        make.left.equalTo(_backView.mas_left);
        make.top.equalTo(_backView.mas_top);
        make.bottom.equalTo(_line.mas_top);
    }];
    
    [_caseShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView.mas_right);
        make.left.equalTo(_backView.mas_left);
        make.top.equalTo(_line.mas_bottom);
        make.bottom.equalTo(_backView.mas_bottom);
    }];
}

- (void)remove
{
    [self removeFromSuperview];
}

- (void)modelShareEven
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickModelShare)]) {
        [self.delegate clickModelShare];
    }
    [self removeFromSuperview];
}

- (void)caseShareEven
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCaseShare)]) {
        [self.delegate clickCaseShare];
    }
    [self removeFromSuperview];
}

@end
