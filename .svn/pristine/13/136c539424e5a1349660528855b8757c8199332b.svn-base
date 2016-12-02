//
//  TMXUnbindListCell.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXUnbindListCell.h"
#import "TMXUnbindModel.h"

@interface TMXUnbindListCell ()

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *printerName;
@property (nonatomic, strong)UIImageView *selectUser;

@end
@implementation TMXUnbindListCell

#pragma mark - lazyLoad
-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"LoginIcon"];
        _icon.layer.cornerRadius = 15*AppScale;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

-(UILabel *)printerName
{
    if (!_printerName) {
        _printerName = [[UILabel alloc] init];
        _printerName.font = [UIFont systemFontOfSize:13*AppScale];
//        _printerName.text = @"我的好邻居";
    }
    return _printerName;
}

-(UIImageView *)selectUser
{
    if (!_selectUser) {
        _selectUser = [[UIImageView alloc] init];
    }
    return _selectUser;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.selectUser.image = [UIImage imageNamed:@"DefaultSelectIcon"];
    }else
    {
         self.selectUser.image = [UIImage imageNamed:@""];
    }
}

- (void)initUI
{
    [self addSubview:self.icon];
    [self addSubview:self.printerName];
    [self addSubview:self.selectUser];
    
    [self updateConstraints];
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(15*AppScale);
        make.size.mas_equalTo(CGSizeMake(30*AppScale, 30*AppScale));
    }];
    
    [_selectUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-15*AppScale);
        make.size.mas_equalTo(CGSizeMake(18*AppScale, 18*AppScale));
    }];
    
    [_printerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_icon.mas_right).offset(10*AppScale);
        make.right.equalTo(_selectUser.mas_left).offset(-10*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setListModel:(TMXUnbindInfoListModel *)listModel
{
    _listModel = listModel;
    _printerName.text = listModel.userName;
    [_icon sd_setImageWithURL:[NSURL URLWithString:listModel.avatar] placeholderImage:nil];
}

@end
