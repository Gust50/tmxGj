//
//  TMXHomeHeaderView.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeHeaderView.h"
#import "TMXHomeModel.h"

@interface TMXHomeHeaderView ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *moreLab;

@end

@implementation TMXHomeHeaderView

#pragma mark <lazyLoad>
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
//        _icon.image = [UIImage imageNamed:@"Toy"];
    }
    return _icon;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[UILabel new];
//        _nameLab.text=@"玩具模型";
        _nameLab.font = [UIFont systemFontOfSize:13*AppScale];
        _nameLab.textColor = RGBColor(91, 91, 91);
    }
    return _nameLab;
}

-(UILabel *)moreLab{
    if (!_moreLab) {
        _moreLab=[UILabel new];
        NSString *_more = NSLocalizedString(@"More", nil);
        _moreLab.text=_more;
        _moreLab.font = [UIFont systemFontOfSize:12*AppScale];
        _moreLab.textColor = RGBColor(166, 166, 166);
        _moreLab.textAlignment=NSTextAlignmentRight;
    }
    return _moreLab;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreModelList)];
        [self addGestureRecognizer:gesture];
        [self initUI];
    }
    return self;
}


-(void)initUI{
    [self addSubview:self.icon];
    [self addSubview:self.nameLab];
    [self addSubview:self.moreLab];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(18*AppScale, 18*AppScale));
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(@(120*AppScale));
    }];
    
    [_moreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(@(120*AppScale));
    }];
}

//跳转模型列表
- (void)moreModelList
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickMoreModel:name:)]) {
        [self.delegate clickMoreModel:self.categoryModelListModel.categoryModelID name:self.categoryModelListModel.name];
    }
}

#pragma mark - setter getter
-(void)setCategoryModelListModel:(TMXHomeCategoryModelListModel *)categoryModelListModel
{
    _categoryModelListModel = categoryModelListModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:categoryModelListModel.smallIcon] placeholderImage:nil];
    _nameLab.text = categoryModelListModel.name;
}

@end
