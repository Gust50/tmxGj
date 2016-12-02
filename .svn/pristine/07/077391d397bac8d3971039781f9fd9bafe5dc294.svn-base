//
//  TMXLeftHeaderView.m
//  TMX3DPrinterHD
//
//  Created by kobe on 16/8/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXLeftHeaderView.h"

@interface TMXLeftHeaderView ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleName;
@property (nonatomic, strong) UILabel *subTitleName;
@property (nonatomic, strong) UIImageView *backGroundImg;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation TMXLeftHeaderView


-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=30.0*AppScale;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconGesture:)];
        _icon.userInteractionEnabled=YES;
        [_icon addGestureRecognizer:tap];
    }
    return _icon;
}

-(UIImageView *)backGroundImg{
    if (!_backGroundImg) {
        _backGroundImg=[UIImageView new];
    }
    return _backGroundImg;
}

-(UILabel *)titleName{
    if (!_titleName) {
        _titleName=[UILabel new];
        _titleName.font=[UIFont systemFontOfSize:13*AppScale];
        _titleName.textAlignment=NSTextAlignmentLeft;
    }
    return _titleName;
}

-(UILabel *)subTitleName{
    if (!_subTitleName) {
        _subTitleName=[UILabel new];
        _subTitleName.font=[UIFont boldSystemFontOfSize:10*AppScale];
        _subTitleName.textColor = RGBColor(113, 113, 113);
        _subTitleName.textAlignment=NSTextAlignmentLeft;
    }
    return _subTitleName;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn=[UIButton buttonWithType:0];
        NSString *_noLogin=NSLocalizedString(@"NoLogin", nil);
        [_loginBtn setTitle:_noLogin forState:0];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:0];
        _loginBtn.titleLabel.font=[UIFont systemFontOfSize:15*AppScale];
        _loginBtn.layer.cornerRadius=5.0;
        _loginBtn.layer.masksToBounds=YES;
        _loginBtn.layer.borderColor=[UIColor blackColor].CGColor;
        _loginBtn.layer.borderWidth=1.0;
        [_loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.backGroundImg];
    
    if (_isLogin) {
        
        [self addSubview:self.icon];
        [self addSubview:self.titleName];
        [self addSubview:self.subTitleName];
        
    }else{
        [self addSubview:self.loginBtn];
    }
    
    
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    if (_isLogin) {
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
            make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
            make.size.mas_equalTo(CGSizeMake(60*AppScale, 60*AppScale));
        }];
        
        [_titleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_icon.mas_centerY).with.offset(-10*AppScale);
            make.left.equalTo(_icon.mas_right).with.offset(10*AppScale);
            make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
            make.height.mas_equalTo(@(20*AppScale));
        }];
        
        [_subTitleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_icon.mas_centerY).with.offset(10*AppScale);
            make.left.equalTo(_icon.mas_right).with.offset(10*AppScale);
            make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
            make.height.mas_equalTo(@(20*AppScale));
        }];
    }else{
        
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(weakSelf.mas_top).with.offset(35);
            make.size.mas_equalTo(CGSizeMake(100*AppScale,35*AppScale));
        }];
    }

    [_backGroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}


#pragma mark <otherResponse>
-(void)loginBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickLogin)]) {
        [self.delegate clickLogin];
    }
}

-(void)iconGesture:(UITapGestureRecognizer *)gesture{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchIcon)]) {
        [self.delegate touchIcon];
    }
}

#pragma mark <getter setter>
-(void)setIconUrl:(NSString *)iconUrl{
    [_icon sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:nil];
}

-(void)setTitleNameText:(NSString *)titleNameText{
    _titleName.text=titleNameText;
}

-(void)setSubTitleNameText:(NSString *)subTitleNameText{
    _subTitleName.text=subTitleNameText;
}

-(void)setBackGroundImgUrl:(NSString *)backGroundImgUrl{
    _backGroundImgUrl = backGroundImgUrl;
    _backGroundImg.image = [UIImage imageNamed:backGroundImgUrl];
}

-(void)setIsLogin:(BOOL)isLogin{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    _isLogin=isLogin;
    [self initUI];
    NSString *_noLogin=NSLocalizedString(@"NoLogin", nil);
    [_loginBtn setTitle:_noLogin forState:0];
}
@end
