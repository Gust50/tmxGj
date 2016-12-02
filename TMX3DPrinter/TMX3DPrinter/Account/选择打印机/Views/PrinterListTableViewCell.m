//
//  PrinterListTableViewCell.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "PrinterListTableViewCell.h"
#import "TMXPrinterListModel.h"

@implementation PrinterListTableViewCell

#pragma mark -- 懒加载
- (UIImageView *)printerImage{
    
    if (!_printerImage) {
        _printerImage = [[UIImageView alloc] init];
        _printerImage.image = [UIImage imageNamed:@"BindPrinterIcon"];
    }
    return _printerImage;
}

- (UILabel *)nameLable{
    
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.textColor = RGBColor(51, 51, 51);
        _nameLable.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _nameLable;
}

-(UILabel *)stateLabel{
    
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.textColor = RGBColor(102, 102, 102);
        _stateLabel.font = [UIFont systemFontOfSize:11*AppScale];
    }
    return _stateLabel;
}

- (UIImageView *)selectImage{
    
    if (!_selectImage) {
        _selectImage = [[UIImageView alloc] init];
    }
    return _selectImage;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [_selectImage setImage:[UIImage imageNamed:@"DefaultSelectIcon"]];
    }else
    {
        [_selectImage setImage:[UIImage imageNamed:@""]];
    }
}

- (void)initUI{
    
    [self addSubview:self.printerImage];
    [self addSubview:self.nameLable];
    [self addSubview:self.selectImage];
    [self addSubview:self.stateLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    [_printerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(@(35*AppScale));
        make.width.mas_equalTo(@(27*AppScale));
    }];
    
    [_selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-15*AppScale);
        make.height.mas_equalTo(@(18*AppScale));
        make.width.mas_equalTo(@(18*AppScale));
        
    }];
    
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_printerImage.mas_right).with.offset(10*AppScale);
        make.right.equalTo(_selectImage.mas_left).with.offset(-10*AppScale);
        make.top.equalTo(_printerImage.mas_top);
        make.height.mas_equalTo(@(18*AppScale));
    }];
    
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_printerImage.mas_right).with.offset(10*AppScale);
        make.bottom.equalTo(_printerImage.mas_bottom);
        make.right.equalTo(_selectImage.mas_left).with.offset(-10*AppScale);
        make.height.equalTo(@(15*AppScale));
    }];
    
}

#pragma mark - setter getter
-(void)setPrinterListModel:(TMXPrinterListListModel *)printerListModel
{
    _printerListModel = printerListModel;
    if (printerListModel.printerName.length) {
        _nameLable.text = printerListModel.printerName;
    }else
    {
        _nameLable.text = [NSString stringWithFormat:@"#%ld", printerListModel.printerListID];
    }
    NSString *stat = NSLocalizedString(@"LinkStatu", nil);
    if ([printerListModel.status isEqualToString:@"1"]) {
        NSString *str = NSLocalizedString(@"Offline", nil);
        _stateLabel.text = [NSString stringWithFormat:@"%@%@", stat,str];
    }else
    {
        NSString *str = NSLocalizedString(@"Online", nil);
        _stateLabel.text = [NSString stringWithFormat:@"%@%@", stat,str];
    }
    if ([printerListModel.status isEqualToString:@"1"]) {
        
        _stateLabel.textColor = RGBColor(102, 102, 102);
        
    }else
    {
        [NSString labelString:_stateLabel font:[UIFont systemFontOfSize:11*AppScale] range:NSMakeRange(stat.length, _stateLabel.text.length - stat.length) color:systemColor];
    }
}

-(void)setSharePrinterList:(TMXPrinterListShareListModel *)sharePrinterList
{
    _sharePrinterList = sharePrinterList;
    if (sharePrinterList.printerName.length) {
        _nameLable.text = sharePrinterList.printerName;
    }else
    {
        _nameLable.text = [NSString stringWithFormat:@"#%ld", sharePrinterList.sharePrinterListID];
    }
    NSString *stat = NSLocalizedString(@"LinkStatu", nil);
    if ([sharePrinterList.status isEqualToString:@"1"]) {
        NSString *str = NSLocalizedString(@"Offline", nil);
        _stateLabel.text = [NSString stringWithFormat:@"%@%@", stat,str];
    }else
    {
        NSString *str = NSLocalizedString(@"Online", nil);
        _stateLabel.text = [NSString stringWithFormat:@"%@%@", stat,str];
    }
    if ([sharePrinterList.status isEqualToString:@"1"]) {
        _stateLabel.textColor = RGBColor(102, 102, 102);
        
    }else
    {
        [NSString labelString:_stateLabel font:[UIFont systemFontOfSize:11*AppScale] range:NSMakeRange(stat.length, _stateLabel.text.length - stat.length) color:systemColor];
    }
}

@end
