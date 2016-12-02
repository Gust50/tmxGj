//
//  TMXAddPrinterCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/9/22.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXAddPrinterCell.h"
#import "TMXScanQRCodeModel.h"

@interface TMXAddPrinterCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *printerNameLab;
@property (nonatomic, strong) UIButton *addPrinterBtn;
@end

@implementation TMXAddPrinterCell

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.image = [UIImage imageNamed:@"BindPrinterIcon"];
    }
    return _icon;
}

-(UILabel *)printerNameLab{
    if (!_printerNameLab) {
        _printerNameLab=[UILabel new];
        _printerNameLab.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _printerNameLab;
}

-(UIButton *)addPrinterBtn{
    if (!_addPrinterBtn) {
        _addPrinterBtn=[UIButton buttonWithType:0];
        [_addPrinterBtn addTarget:self action:@selector(touchAddPrinterBtn:) forControlEvents:UIControlEventTouchUpInside];
        _addPrinterBtn.layer.cornerRadius = 2;
        _addPrinterBtn.layer.masksToBounds = YES;
        _addPrinterBtn.layer.borderColor = systemColor.CGColor;
        _addPrinterBtn.layer.borderWidth = 1;
        _addPrinterBtn.backgroundColor = [UIColor whiteColor];
        [_addPrinterBtn setTitle:NSLocalizedString(@"Add", nil) forState:UIControlStateNormal];
        [_addPrinterBtn setTitleColor:systemColor forState:UIControlStateNormal];
        _addPrinterBtn.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _addPrinterBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.printerNameLab];
    [self addSubview:self.addPrinterBtn];
    [self updateConstraints];
}


-(void)touchAddPrinterBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPrinter)]) {
        [self.delegate addPrinter];
    }
}
-(void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(35*AppScale, 40*AppScale));
    }];
    
    [_printerNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_icon.mas_right).with.offset(8*AppScale);
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 30*AppScale));
    }];
    
    [_addPrinterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50*AppScale, 25*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setModel:(TMXScanQRCodeModel *)model
{
    _model = model;
    if (model.name.length != 0) {
        _printerNameLab.text = model.name;
    }else
    {
        _printerNameLab.text = [NSString stringWithFormat:@"#%ld", model.printerId];
    }
    
}

@end
