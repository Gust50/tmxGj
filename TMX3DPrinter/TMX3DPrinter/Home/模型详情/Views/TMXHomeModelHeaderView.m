//
//  TMXHomeHeaderView.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeModelHeaderView.h"

@interface TMXHomeModelHeaderView ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIImageView *arrow;
@end


@implementation TMXHomeModelHeaderView

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
//        _icon.image = [UIImage imageNamed:@"ModelFileListIcon"];
    }
    return _icon;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.font = [UIFont systemFontOfSize:12*AppScale];
        _titleLab.textColor = RGBColor(64, 64, 64);
    }
    return _titleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab=[UILabel new];
        NSString *_select = NSLocalizedString(@"SelectPrinter", nil);
        _subTitleLab.text = _select;
        _subTitleLab.textAlignment = NSTextAlignmentRight;
        _subTitleLab.font = [UIFont systemFontOfSize:10*AppScale];
        _subTitleLab.textColor = RGBColor(115, 115, 115);
    }
    return _subTitleLab;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[UIView new];
         _bottomLine.backgroundColor = RGBColor(231, 231, 231);
    }
    return _bottomLine;
}

-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow=[UIImageView new];
        _arrow.image = [UIImage imageNamed:@"RightArrowIcon"];
    }
    return _arrow;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPrinter)];
        [self addGestureRecognizer:gesture];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.titleLab];
    [self addSubview:self.subTitleLab];
    [self addSubview:self.arrow];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15*AppScale, 15*AppScale));
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 15*AppScale));
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10*AppScale, 10*AppScale));
    }];
    
    [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_titleLab.mas_right).offset(10*AppScale);
        make.right.equalTo(_arrow.mas_left).offset(-10*AppScale);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(1));
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-1);
    }];
    
}

#pragma mark - setter getter
-(void)setIconUrl:(NSString *)iconUrl
{
    _iconUrl = iconUrl;
    _icon.image = [UIImage imageNamed:iconUrl];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLab.text = title;
}

-(void)setLeng:(NSString *)leng
{
    _leng = leng;
}

- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    _subTitleLab.text = subTitle;
    if (_subTitleLab.text.length) {
        if (self.isHideArrow) {
            NSScanner *scanner = [NSScanner scannerWithString:subTitle];
            [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
            
            int number;
            [scanner scanInt:&number];
            NSString *num=[NSString stringWithFormat:@"%d",number];
            [NSString labelString:_subTitleLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_leng.length, num.length) color:systemColor];
        }
    }else
    {
        if (!self.isHideArrow) {
            NSString *_select = NSLocalizedString(@"SelectPrinter", nil);
            _subTitleLab.text = _select;
        }
    }
}

-(void)setIsHideArrow:(BOOL)isHideArrow
{
    _isHideArrow = isHideArrow;
    self.arrow.hidden = isHideArrow;
}

//选择打印机
- (void)selectPrinter
{
    if (!self.isHideArrow) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickSelectPrinter)]) {
            [self.delegate clickSelectPrinter];
        }
    }
    
}

@end
