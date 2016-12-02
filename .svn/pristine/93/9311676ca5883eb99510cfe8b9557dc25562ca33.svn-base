//
//  TMXLanguageCell.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/10/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXLanguageCell.h"

@interface TMXLanguageCell ()
@property (nonatomic, strong)UILabel *language;
@property (nonatomic, strong)UIImageView *selectIcon;
@end
@implementation TMXLanguageCell

-(UILabel *)language
{
    if (!_language) {
        _language = [UILabel new];
        _language.textAlignment = NSTextAlignmentCenter;
        _language.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _language;
}

-(UIImageView *)selectIcon
{
    if (!_selectIcon) {
        _selectIcon = [UIImageView new];
        _selectIcon.image = [UIImage imageNamed:@"Restore_select"];
    }
    return _selectIcon;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
        self.selectIcon.hidden = YES;

    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.language];
    [self.language addSubview:self.selectIcon];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    WS(weakSelf);
    [_language mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    [_selectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15*AppScale, 15*AppScale));
        make.centerY.equalTo(_language.mas_centerY);
        make.right.equalTo(_language.mas_right).offset(-40*AppScale);
    }];
}

-(void)setLanguageType:(NSString *)languageType{
    _languageType=languageType;
    _language.text=languageType;
}

-(void)setIsSelect:(BOOL)isSelect{
    _isSelect=isSelect;
    if (isSelect) {
        self.selectIcon.hidden = NO;
    }else
    {
        self.selectIcon.hidden = YES;
    }
}
@end
