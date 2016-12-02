//
//  TMXPopMenuSelectTableViewCell.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPopMenuSelectTableViewCell.h"

@implementation TMXPopMenuSelectTableViewCell

#pragma mark -- 懒加载
- (UILabel *)describLabel{

    if (!_describLabel) {
        _describLabel = [[UILabel alloc] init];
        _describLabel.text = NSLocalizedString(@"Set_default", nil);
        _describLabel.textColor = RGBColor(45, 45, 45);
        _describLabel.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _describLabel;
}

- (UISwitch *)selectSwitch{

    if (!_selectSwitch) {
        _selectSwitch = [[UISwitch alloc] init];
        [_selectSwitch addTarget:self action:@selector(clickIsDefault:) forControlEvents:UIControlEventValueChanged];
    }
    return _selectSwitch;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.describLabel];
    [self addSubview:self.selectSwitch];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_describLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
    }];
    
    [_selectSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(25*AppScale));
        make.width.equalTo(@(40*AppScale));
    }];
}

//设置默认
- (void)clickIsDefault:(UISwitch *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTMXPopMenuSelectTableViewCellDelegate:)]) {
        [self.delegate clickTMXPopMenuSelectTableViewCellDelegate:sender.on];
    }
}

#pragma mark - setter getter
-(void)setIsDefault:(BOOL)isDefault
{
    _isDefault = isDefault;
    _selectSwitch.on = isDefault;
}



@end
