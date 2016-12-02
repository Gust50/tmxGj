//
//  TMXShareSettingCell.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXShareSettingCell.h"

@implementation TMXShareSettingCell

#pragma mark -- 懒加载
- (UILabel *)describLabel{

    if (!_describLabel) {
        _describLabel = [[UILabel alloc] init];
        _describLabel.textColor = RGBColor(51, 51, 51);
        _describLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _describLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _describLabel;
}

- (UITextField *)KtextField{

    if (!_KtextField) {
        _KtextField = [[UITextField alloc] init];
        _KtextField.layer.masksToBounds = YES;
        _KtextField.layer.cornerRadius = 5;
        _KtextField.layer.borderWidth = 1;
        _KtextField.layer.borderColor = RGBColor(51, 51, 51).CGColor;
    }
    return _KtextField;
}

- (UILabel *)countLabel{

    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = RGBColor(51, 51, 51);
        _countLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _countLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _countLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.describLabel];
    [self addSubview:self.KtextField];
    [self addSubview:self.countLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_describLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(70*AppScale));
    }];
    
    [_KtextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_describLabel.mas_right).with.offset(5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(30*AppScale));
        make.width.equalTo(@(80*AppScale));
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_KtextField.mas_right).with.offset(3*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
