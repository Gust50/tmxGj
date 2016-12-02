//
//  TMXHomeIntroductModelCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeIntroductModelCell.h"

@interface TMXHomeIntroductModelCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UILabel *contentLab;

@end


@implementation TMXHomeIntroductModelCell

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.image = [UIImage imageNamed:@"ModelIntroIcon"];
    }
    return _icon;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[UILabel new];
        NSString *_introduce = NSLocalizedString(@"Introduce", nil);
        _nameLab.text = _introduce;
        _nameLab.font = [UIFont systemFontOfSize:12*AppScale];
        _nameLab.textColor = RGBColor(64, 64, 64);
    }
    return _nameLab;
}

-(UIView *)topLine{
    if (!_topLine) {
        _topLine=[UIView new];
        _topLine.backgroundColor = RGBColor(231, 231, 231);
    }
    return _topLine;
}

-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab=[UILabel new];
        _contentLab.font = [UIFont systemFontOfSize:11*AppScale];
        _contentLab.textColor = RGBColor(64, 64, 64);
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.icon];
    [self addSubview:self.nameLab];
    [self addSubview:self.topLine];
    [self addSubview:self.contentLab];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.size.mas_offset(CGSizeMake(15*AppScale, 15*AppScale));
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).with.offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(1));
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.top.equalTo(_topLine.mas_bottom).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-5*AppScale);
    }];
}

#pragma mark - setter getter
-(void)setModelInfo:(NSString *)modelInfo
{
    _modelInfo = modelInfo;
    _contentLab.text = modelInfo;

}

@end
