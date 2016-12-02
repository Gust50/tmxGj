//
//  TMXHomeModelRemarkCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeModelRemarkCell.h"

@interface TMXHomeModelRemarkCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *remarkLab;

@property (nonatomic, assign) CGFloat remarkHeight;
@end


@implementation TMXHomeModelRemarkCell

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.image = [UIImage imageNamed:@"LoginIcon"];
        _icon.layer.cornerRadius = 15*AppScale;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[UILabel new];
        _nameLab.font = [UIFont systemFontOfSize:11*AppScale];
        _nameLab.textColor = RGBColor(64, 64, 64);
    }
    return _nameLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[UILabel new];
        _timeLab.font = [UIFont systemFontOfSize:10*AppScale];
        _timeLab.textColor = RGBColor(159, 159, 159);
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

-(UILabel *)remarkLab{
    if (!_remarkLab) {
        _remarkLab=[UILabel new];
        _remarkLab.numberOfLines = 0;
        _remarkLab.font = [UIFont systemFontOfSize:10*AppScale];
        _remarkLab.textColor = RGBColor(64, 64, 64);
    }
    return _remarkLab;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.remarkHeight=20.0*AppScale;
    }
    return self;
}


-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.nameLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.remarkLab];
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(30*AppScale, 30*AppScale));
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.right.equalTo(_timeLab.mas_left).with.offset(-5*AppScale);
        make.centerY.equalTo(_icon.mas_centerY);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(_icon.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 20*AppScale));
    }];
    
    [_remarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.top.equalTo(_icon.mas_bottom).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
    }];
    
    [_remarkLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(_remarkHeight));
    }];
   
}


@end
