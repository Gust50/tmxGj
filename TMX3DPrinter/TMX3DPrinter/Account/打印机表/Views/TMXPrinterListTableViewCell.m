//
//  TMXPrinterListTableViewCell.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterListTableViewCell.h"
#import "TMXPrinterListModel.h"

@interface TMXPrinterListTableViewCell ()
{
    CGFloat defaultWidth;
}

@end
@implementation TMXPrinterListTableViewCell

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

- (UILabel *)isDefault{

    if (!_isDefault) {
        _isDefault = [[UILabel alloc] init];
        NSString *_default = NSLocalizedString(@"Default", nil);
        _isDefault.text = _default;
        
        _isDefault.textColor = [UIColor whiteColor];
        _isDefault.backgroundColor = systemColor;
        _isDefault.layer.masksToBounds = YES;
        _isDefault.layer.cornerRadius = 5;
        _isDefault.font = [UIFont systemFontOfSize:11*AppScale];
        _isDefault.textAlignment = NSTextAlignmentCenter;
        _isDefault.hidden = YES;
        CGSize size = [NSString sizeWithStr:_isDefault.text font:[UIFont systemFontOfSize:11*AppScale] width:120];
        defaultWidth = size.width;
    }
    return _isDefault;
}

- (UILabel *)WIFIStateLabel{
    
    if (!_WIFIStateLabel) {
        _WIFIStateLabel = [[UILabel alloc] init];
        _WIFIStateLabel.textColor = RGBColor(102, 102, 102);
        _WIFIStateLabel.font = [UIFont systemFontOfSize:11*AppScale];
    }
    return _WIFIStateLabel;
}

- (UIButton *)selectButton{
    
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:0];
        [_selectButton setImage:[UIImage imageNamed:@"editPrinter"] forState:(UIControlStateNormal)];
        [_selectButton addTarget:self action:@selector(selectButtonCliked) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _selectButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.printerImage];
    [self addSubview:self.nameLable];
    [self addSubview:self.isDefault];
    [self addSubview:self.WIFIStateLabel];
    [self addSubview:self.selectButton];
    
    [self updateConstraints];
}

- (void)selectButtonCliked{

    if (self.selectblock) {
        self.selectblock();
    }
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    [_printerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(38*AppScale));
        make.width.equalTo(@(30*AppScale));
    }];
    
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_printerImage.mas_right).with.offset(10*AppScale);
        make.top.equalTo(_printerImage.mas_top);
        make.height.equalTo(@(20*AppScale));
    }];
    
    [_isDefault mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_nameLable.mas_right).with.offset(5*AppScale);
        make.centerY.equalTo(_nameLable.mas_centerY);
        make.height.equalTo(@(15*AppScale));
        make.width.equalTo(@(defaultWidth));
    }];
    
    [_WIFIStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_printerImage.mas_right).with.offset(10*AppScale);
        make.bottom.equalTo(_printerImage.mas_bottom);
        make.height.equalTo(@(15*AppScale));
        make.right.equalTo(_selectButton.mas_left).offset(10*AppScale);
    }];
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.equalTo(@(60*AppScale));
        
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
        _WIFIStateLabel.text = [NSString stringWithFormat:@"%@%@", stat,str];
    }else
    {
        NSString *str = NSLocalizedString(@"Online", nil);
        _WIFIStateLabel.text = [NSString stringWithFormat:@"%@%@", stat,str];
    }
    
    if ([printerListModel.status isEqualToString:@"1"]) {
        _WIFIStateLabel.textColor = RGBColor(102, 102, 102);
    }else
    {
        NSString *str = NSLocalizedString(@"Online", nil);
        [NSString labelString:_WIFIStateLabel font:[UIFont systemFontOfSize:11*AppScale] range:NSMakeRange(stat.length, str.length) color:RGBColor(234, 97, 1)];
    }
    if (printerListModel.isDefault) {
        _isDefault.hidden = NO;
    }else
    {
        _isDefault.hidden = YES;
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
        _WIFIStateLabel.text = [NSString stringWithFormat:@"%@%@", stat,str];
    }else
    {
        NSString *str = NSLocalizedString(@"Online", nil);
        _WIFIStateLabel.text = [NSString stringWithFormat:@"%@%@", stat,str];
    }
    if ([sharePrinterList.status isEqualToString:@"1"]) {
        _WIFIStateLabel.textColor = RGBColor(102, 102, 102);
    }else
    {
        NSString *str = NSLocalizedString(@"Online", nil);
        [NSString labelString:_WIFIStateLabel font:[UIFont systemFontOfSize:11*AppScale] range:NSMakeRange(stat.length, str.length) color:RGBColor(234, 97, 1)];
    }
    if (sharePrinterList.isDefault) {
        _isDefault.hidden = NO;
    }else
    {
        _isDefault.hidden = YES;
    }
}

@end
