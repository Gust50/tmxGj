//
//  TMXLeftVCCell.m
//  TMX3DPrinterHD
//
//  Created by kobe on 16/8/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXLeftVCCell.h"

@interface TMXLeftVCCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@end

@implementation TMXLeftVCCell

#pragma mark <lazyLoad>
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
    }
    return _icon;
}

-(UILabel *)name{
    if (!_name) {
        _name=[UILabel new];
        _name.textAlignment=NSTextAlignmentLeft;
        _name.textColor=[UIColor whiteColor];
        _name.font=[UIFont systemFontOfSize:13*AppScale];
    }
    return _name;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor=RGBColor(237, 109, 0);
    }
    return self;
}

#pragma mark <initUI>
-(void)initUI{
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self updateConstraints];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:YES];
    if (selected) {
        self.contentView.backgroundColor=[UIColor whiteColor];
         _name.textColor = RGBColor(237, 109, 0);
        _icon.image=[UIImage imageNamed:@"Home_select"];
        
    }else{
        self.contentView.backgroundColor=RGBColor(237, 109, 0);
         _name.textColor = [UIColor whiteColor];
    }
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(_name.mas_left).with.offset(-20*AppScale);
        make.size.mas_equalTo(CGSizeMake(18*AppScale, 18*AppScale));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 30*AppScale));
    }];
}

#pragma mark <getter setter>
-(void)setIconUrl:(NSString *)iconUrl{
    _iconUrl = iconUrl;
    _icon.image=[UIImage imageNamed:iconUrl];
}

-(void)setNameText:(NSString *)nameText{
    _nameText = nameText;
    _name.text=nameText;
}

-(void)setSelectIconUrl:(NSString *)selectIconUrl{
    _icon.image = [UIImage imageNamed:selectIconUrl];
}

-(void)setSelectTextColor:(UIColor *)selectTextColor{
    _name.textColor=selectTextColor;
}
@end
