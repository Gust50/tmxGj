//
//  TMXLoginSelectUserCell.m
//  TMX3DPrinterHD
//
//  Created by wutaobo on 2016/11/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXLoginSelectUserCell.h"

@interface TMXLoginSelectUserCell ()

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *userName;
@property (nonatomic, strong)UIButton *deleteBtn;

@end
@implementation TMXLoginSelectUserCell

-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"Icon"];
        _icon.layer.cornerRadius = 15*AppScale;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

-(UILabel *)userName
{
    if (!_userName) {
        _userName = [UILabel new];
        _userName.font = [UIFont systemFontOfSize:13*AppScale];
        _userName.textColor = RGBColor(84, 83, 83);
        _userName.text = @"13125382478";
    }
    return _userName;
}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton new];
        [_deleteBtn setImage:[UIImage imageNamed:@"DeleteUesrIcon"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteUserName) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.icon];
    [self addSubview:self.userName];
    [self addSubview:self.deleteBtn];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(30*AppScale, 30*AppScale));
    }];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.size.mas_equalTo(CGSizeMake(15*AppScale, 15*AppScale));
    }];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_icon.mas_right).with.offset(10*AppScale);
        make.right.equalTo(_deleteBtn.mas_left).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

//删除账号
- (void)deleteUserName
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickDeleteAccount:)]) {
        [self.delegate clickDeleteAccount:_userName.text];
    }
}

#pragma mark - setter getter
-(void)setUserNameLab:(NSString *)userNameLab
{
    _userNameLab = userNameLab;
    _userName.text = userNameLab;
}

@end
