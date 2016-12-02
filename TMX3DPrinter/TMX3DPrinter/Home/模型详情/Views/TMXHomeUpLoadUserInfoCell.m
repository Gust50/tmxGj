//
//  TMXHomeUpLoadUserInfoCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeUpLoadUserInfoCell.h"
#import "TMXHomeModelDetailModel.h"

@interface TMXHomeUpLoadUserInfoCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *userNameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIImageView *arrow;
@end

@implementation TMXHomeUpLoadUserInfoCell

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.image = [UIImage imageNamed:@"LoginIcon"];
        _icon.layer.cornerRadius = 15*AppScale;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

-(UILabel *)userNameLab{
    if (!_userNameLab) {
        _userNameLab=[UILabel new];
        _userNameLab.font = [UIFont systemFontOfSize:11*AppScale];
        _userNameLab.textColor = RGBColor(64, 64, 64);
    }
    return _userNameLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[UILabel new];
        _timeLab.font = [UIFont systemFontOfSize:11*AppScale];
        _timeLab.textColor = RGBColor(91, 91, 91);
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow=[UIImageView new];
        _arrow.image = [UIImage imageNamed:@"RightArrowIcon"];
    }
    return _arrow;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.userNameLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.arrow];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30*AppScale, 30*AppScale));
    }];
    
    [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(_timeLab.mas_left).with.offset(10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_arrow.mas_left).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10*AppScale, 10*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setDetailModel:(TMXHomeModelDetailModel *)detailModel
{
    _detailModel = detailModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:detailModel.ownerAvatar] placeholderImage:nil];
    _userNameLab.text = detailModel.ownerName;
    
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([detailModel.updatedDate doubleValue]/1000.0)];
    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
    _timeLab.text = timeString;
}

@end
