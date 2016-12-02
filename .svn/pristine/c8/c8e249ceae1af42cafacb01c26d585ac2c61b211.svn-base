//
//  TMXWaitPrinterCell.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/9.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXWaitPrinterCell.h"
#import "TMXWaitPrinterModel.h"

@interface TMXWaitPrinterCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *suppliesLab;
@property (nonatomic, strong) UILabel *printState;
@property (nonatomic, strong) UIImageView *sign;

@end
@implementation TMXWaitPrinterCell

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

-(UILabel *)printState
{
    if (!_printState) {
        _printState=[UILabel new];
        _printState.textColor = RGBColor(64, 64, 64);
        _printState.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _printState;
}

-(UIImageView *)sign
{
    if (!_sign) {
        _sign = [UIImageView new];
        _sign.image = [UIImage imageNamed:@"iconfont-duihao-copy"];
        _sign.hidden = YES;
    }
    return _sign;
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
    [self addSubview:self.printState];
    [self.icon addSubview:self.sign];
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
    
    [_sign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_icon.mas_right);
        make.bottom.equalTo(_icon.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(15*AppScale, 15*AppScale));
    }];
    
    [_printState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40*AppScale, 25*AppScale));
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.top.equalTo(_icon.mas_top);
        make.right.equalTo(_printState.mas_left).with.offset(-5*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.bottom.equalTo(_icon.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
    [_suppliesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLab.mas_right).with.offset(5*AppScale);
        make.bottom.equalTo(_icon.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
}

#pragma mark - setter getter
-(void)setWaitPriterListModel:(TMXWaitPrinterListModel *)waitPriterListModel
{
    _waitPriterListModel = waitPriterListModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:waitPriterListModel.filePathImg] placeholderImage:nil];
    _nameLab.text = waitPriterListModel.fileName;
    if (waitPriterListModel.printTime.length) {
        NSString *con = NSLocalizedString(@"Consuming", nil);
        _timeLab.text = [NSString stringWithFormat:@"%@%@", con,waitPriterListModel.printTime];
        [NSString labelString:_timeLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(con.length, _timeLab.text.length-con.length) color:systemColor];
    }else
    {
        _timeLab.text = NSLocalizedString(@"Consuming", nil);
    }
    
    if (waitPriterListModel.filamentUsed.length) {
        NSString *con = NSLocalizedString(@"Consumables", nil);
        _suppliesLab.text = [NSString stringWithFormat:@"%@%@", con,waitPriterListModel.filamentUsed];
        [NSString labelString:_suppliesLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(con.length, _suppliesLab.text.length-con.length) color:systemColor];
    }else
    {
        _suppliesLab.text = NSLocalizedString(@"Consumables", nil);
    }
    
    
    if (waitPriterListModel.status == 0) {
        _printState.text = NSLocalizedString(@"WaitPrint", nil);
        _printState.textColor = RGBColor(64, 64, 64);
    }else if (waitPriterListModel.status == 1)
    {
        _printState.text = NSLocalizedString(@"Printing", nil);
        _printState.textColor = systemColor;
    }
    if (waitPriterListModel.belongToUser) {
        self.sign.hidden = NO;
    }else
    {
        self.sign.hidden = YES;
    }
}

@end
