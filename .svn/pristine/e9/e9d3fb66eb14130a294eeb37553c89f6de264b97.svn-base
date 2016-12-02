//
//  TMXHomeDetailBrowseView.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeDetailBrowseView.h"

@interface TMXHomeDetailBrowseView ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *browseTipLab;
@property (nonatomic, strong) UILabel *browseLab;
@end

@implementation TMXHomeDetailBrowseView

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.image = [UIImage imageNamed:@"BrowseIcon"];
    }
    return _icon;
}

-(UIView *)line{
    if (!_line) {
        _line=[UIView new];
        _line.backgroundColor = RGBColor(245, 176, 128);
    }
    return _line;
}

-(UILabel *)browseTipLab{
    if (!_browseTipLab) {
        _browseTipLab=[UILabel new];
        NSString *_browse = NSLocalizedString(@"Browse", nil);
        _browseTipLab.text = _browse;
        _browseTipLab.textAlignment = NSTextAlignmentCenter;
        _browseTipLab.font = [UIFont systemFontOfSize:8*AppScale];
    }
    return _browseTipLab;
}

-(UILabel *)browseLab{
    if (!_browseLab) {
        _browseLab=[UILabel new];
        _browseLab.textColor = RGBColor(234, 97, 1);
        _browseLab.textAlignment = NSTextAlignmentCenter;
        _browseLab.font = [UIFont systemFontOfSize:8*AppScale];
    }
    return _browseLab;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = RGBAColor(1, 1, 1, 0.1);
        [self initUI];
    }
    return self;
}


-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.line];
//    [self addSubview:self.browseTipLab];
    [self addSubview:self.browseLab];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(17*AppScale, 12*AppScale));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(7*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-7*AppScale);
        make.width.mas_equalTo(@(1));
    }];
    
//    [_browseTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_line.mas_right);
//        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(-5*AppScale);
//        make.right.equalTo(weakSelf.mas_right);
//        make.height.mas_equalTo(@(15*AppScale));
//    }];
    
    [_browseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_line.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(15*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setBrowseCount:(NSInteger)browseCount
{
    _browseCount = browseCount;
    NSString *count = NSLocalizedString(@"Browse", nil);
    _browseLab.text = [NSString stringWithFormat:@"%ld %@", browseCount,count];
    [NSString labelString:_browseLab font:[UIFont systemFontOfSize:8*AppScale] range:NSMakeRange(_browseLab.text.length-count.length, count.length) color:[UIColor blackColor]];
}

@end
