//
//  TMXHomeModelListCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeModelListCell.h"
#import "TMXHomeModelDetailModel.h"

@interface TMXHomeModelListCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *suppliesLab;
@property (nonatomic, strong) UIButton *printBtn;
@end


@implementation TMXHomeModelListCell

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.image = [UIImage imageNamed:@"LoginIcon"];
    }
    return _icon;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[UILabel new];
        _nameLab.textColor = RGBColor(64, 64, 64);
        _nameLab.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _nameLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[UILabel new];
        _timeLab.textColor = RGBColor(154, 154, 154);
        _timeLab.font = [UIFont systemFontOfSize:10*AppScale];
    }
    return _timeLab;
}

-(UILabel *)suppliesLab{
    if (!_suppliesLab) {
        _suppliesLab=[UILabel new];
        _suppliesLab.textColor = RGBColor(154, 154, 154);
        _suppliesLab.font = [UIFont systemFontOfSize:10*AppScale];
    }
    return _suppliesLab;
}

-(UIButton *)printBtn{
    if (!_printBtn) {
        _printBtn=[UIButton buttonWithType:0];
        _printBtn.backgroundColor = RGBColor(234, 97, 1);
        _printBtn.layer.cornerRadius = 5*AppScale;
        _printBtn.layer.masksToBounds = YES;
        NSString *_print = NSLocalizedString(@"Print", nil);
        [_printBtn setTitle:_print forState:UIControlStateNormal];
        [_printBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _printBtn.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
        [_printBtn addTarget:self action:@selector(printer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _printBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.nameLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.suppliesLab];
    [self addSubview:self.printBtn];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40*AppScale, 40*AppScale));
    }];
    
    [_printBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 25*AppScale));
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(-15*AppScale);
        make.right.equalTo(_printBtn.mas_left).with.offset(-5*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(15*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 15*AppScale));
    }];
    
    [_suppliesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLab.mas_right).with.offset(5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(15*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 15*AppScale));
    }];
    
}

//打印
- (void)printer
{
    if (self.modelDetailPrinterBlock) {
        self.modelDetailPrinterBlock();
    }
}

#pragma mark - setter getter
-(void)setFileListModel:(TMXHomeModelDetailFileListModel *)fileListModel
{
    _fileListModel = fileListModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:fileListModel.image] placeholderImage:nil];
    _nameLab.text = fileListModel.fileName;
    if (fileListModel.printTime.length) {
        NSString *_consuming = NSLocalizedString(@"Consuming", nil);
        _timeLab.text = [NSString stringWithFormat:@"%@%@", _consuming,fileListModel.printTime];
        [NSString labelString:_timeLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_consuming.length, _timeLab.text.length-_consuming.length) color:RGBColor(234, 97, 1)];
    }else
    {
        NSString *_consuming = NSLocalizedString(@"Consuming", nil);
        _timeLab.text = _consuming;
    }
    
    if (fileListModel.filamentUsed.length) {
        NSString *_consumables = NSLocalizedString(@"Consumables", nil);
        _suppliesLab.text = [NSString stringWithFormat:@"%@%@", _consumables,fileListModel.filamentUsed];
        [NSString labelString:_suppliesLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_consumables.length, _suppliesLab.text.length-_consumables.length) color:RGBColor(234, 97, 1)];
    }else
    {
        NSString *_consumables = NSLocalizedString(@"Consumables", nil);
        _suppliesLab.text = _consumables;
    }
    
}

@end
