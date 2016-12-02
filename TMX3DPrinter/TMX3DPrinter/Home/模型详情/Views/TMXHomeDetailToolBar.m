//
//  TMXHomeDetailToolBar.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeDetailToolBar.h"

@interface TMXHomeDetailToolBar ()
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *remarkBtn;
@property (nonatomic, strong) UILabel *line;
@end

@implementation TMXHomeDetailToolBar

-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn=[UIButton buttonWithType:0];
        [_likeBtn setImage:[UIImage imageNamed:@"DetailLike_normal"] forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(likeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

-(UIButton *)remarkBtn{
    if (!_remarkBtn) {
        _remarkBtn=[UIButton buttonWithType:0];
        _remarkBtn.backgroundColor = RGBColor(234, 97, 1);
        NSString *_addComment = NSLocalizedString(@"AddComment", nil);
        [_remarkBtn setTitle:_addComment forState:UIControlStateNormal];
        [_remarkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _remarkBtn.titleLabel.font = [UIFont systemFontOfSize:13*AppScale];
        [_remarkBtn addTarget:self action:@selector(remarkBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _remarkBtn;
}

-(UIButton *)feedBackBtn{
    if (!_feedBackBtn) {
        _feedBackBtn=[UIButton buttonWithType:0];
        _feedBackBtn.backgroundColor = RGBColor(234, 97, 1);
//        [_feedBackBtn setTitle:@"意见反馈" forState:UIControlStateNormal];
        [_feedBackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _feedBackBtn.titleLabel.font = [UIFont systemFontOfSize:13*AppScale];
        [_feedBackBtn addTarget:self action:@selector(feedBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feedBackBtn;
}

-(UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor whiteColor];
    }
    return _line;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}


-(void)initUI{
    [self addSubview:self.likeBtn];
    [self addSubview:self.remarkBtn];
    [self addSubview:self.feedBackBtn];
    [self addSubview:self.line];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(@(SCREENWIDTH/5));
    }];
    
    [_remarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likeBtn.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(@(SCREENWIDTH*2/5));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_remarkBtn.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(@(1));
    }];
    
    [_feedBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_line.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(@(SCREENWIDTH*2/5));
    }];
}


#pragma mark - setter getter
-(void)setIsLike:(BOOL)isLike
{
    _isLike = isLike;
    if (isLike) {
        [_likeBtn setImage:[UIImage imageNamed:@"DetailLike_select"] forState:UIControlStateNormal];
    }else
    {
        [_likeBtn setImage:[UIImage imageNamed:@"DetailLike_normal"] forState:UIControlStateNormal];
    }
}

-(void)likeBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickLikeBtn)]) {
        [self.delegate clickLikeBtn];
    }
}

-(void)remarkBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickRemarkBtn)]) {
        [self.delegate clickRemarkBtn];
    }
}

-(void)feedBackBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickFeedbackBtn)]) {
        [self.delegate clickFeedbackBtn];
    }
}

@end
