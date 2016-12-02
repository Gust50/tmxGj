//
//  TMXSharePrinterView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXSharePrinterView.h"
#import "TMXSharePrinterModel.h"

@interface TMXSharePrinterView ()
{
    CGFloat height;
}

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *name;
@property (nonatomic, strong)UILabel *printerName;
@property (nonatomic, strong)UILabel *line;
@property (nonatomic, strong)UIImageView *QRCodeView;
@property (nonatomic, strong)UILabel *shareUserCount;
@property (nonatomic, strong)UITextView *textView;

@end
@implementation TMXSharePrinterView

#pragma mark - lazyLoad
-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10*AppScale;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"ToolIcon"];
    }
    return _icon;
}

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _name;
}

-(UILabel *)printerName
{
    if (!_printerName) {
        _printerName = [[UILabel alloc] init];
        _printerName.font = [UIFont systemFontOfSize:11*AppScale];
        _printerName.textColor = RGBColor(109, 109, 109);
    }
    return _printerName;
}

-(UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGBColor(231, 231, 231);
    }
    return _line;
}

-(UIImageView *)QRCodeView
{
    if (!_QRCodeView) {
        _QRCodeView = [[UIImageView alloc] init];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImageView:)];
        _QRCodeView.userInteractionEnabled=YES;
        [_QRCodeView addGestureRecognizer:tap];
    }
    return _QRCodeView;
}

-(UILabel *)shareUserCount
{
    if (!_shareUserCount) {
        _shareUserCount = [[UILabel alloc] init];
        _shareUserCount.textAlignment = NSTextAlignmentCenter;
        _shareUserCount.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _shareUserCount;
}

-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.layer.cornerRadius = 3*AppScale;
        _textView.layer.masksToBounds = YES;
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = RGBColor(234, 97, 1).CGColor;
        _textView.font = [UIFont systemFontOfSize:12*AppScale];
        _textView.text = NSLocalizedString(@"QrCode_describe", nil);
        CGSize size = [NSString sizeWithStr:_textView.text font:[UIFont systemFontOfSize:12*AppScale] width:SCREENWIDTH-80*AppScale];
        height = size.height;
    }
    return _textView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = RGBColor(237, 109, 0);
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.backView];
    [self.backView addSubview:self.icon];
    [self.backView addSubview:self.name];
    [self.backView addSubview:self.printerName];
    [self.backView addSubview:self.line];
    [self.backView addSubview:self.QRCodeView];
    [self.backView addSubview:self.shareUserCount];
    [self.backView addSubview:self.textView];
    
    [self updateConstraints];
}



-(void)touchImageView:(UITapGestureRecognizer *)getture{
    if (self.delegate && [self.delegate respondsToSelector:@selector(saveQRCode:)]) {
        [self.delegate saveQRCode:_QRCodeView.image];
    }
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(30*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-30*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(20*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-20*AppScale);
    }];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).offset(30*AppScale);
        make.left.equalTo(_backView.mas_left).offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake(40*AppScale, 40*AppScale));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_top);
        make.left.equalTo(_icon.mas_right).offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-20*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_printerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_icon.mas_bottom);
        make.left.equalTo(_icon.mas_right).offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-20*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_backView.mas_left).offset(20*AppScale);
        make.right.equalTo(_backView.mas_right).offset(-20*AppScale);
        make.height.mas_equalTo(@(1));
    }];
    
    [_QRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(20*AppScale);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150*AppScale, 150*AppScale));
    }];
    
    [_shareUserCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_QRCodeView.mas_bottom).offset(15*AppScale);
        make.left.equalTo(_backView.mas_left).offset(20*AppScale);
        make.right.equalTo(_backView.mas_right).offset(-20*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backView.mas_bottom).offset(-30*AppScale);
        make.left.equalTo(_backView.mas_left).offset(20*AppScale);
        make.right.equalTo(_backView.mas_right).offset(-20*AppScale);
        make.height.mas_equalTo(@(height+20*AppScale));
    }];
    
}

#pragma mark - setter getter
-(void)setSharePrinterModel:(TMXSharePrinterModel *)sharePrinterModel
{
    _sharePrinterModel = sharePrinterModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:sharePrinterModel.userAvatar] placeholderImage:nil];
    _name.text = sharePrinterModel.userName;
    _printerName.text = sharePrinterModel.printerName;
    NSString *canShare = NSLocalizedString(@"CanShare", nil);
    NSString *place = NSLocalizedString(@"PlaceUser", nil);
    _shareUserCount.text = [NSString stringWithFormat:@"%@ %ld %@", canShare,sharePrinterModel.count,place];
    NSString *str = [NSString stringWithFormat:@"%ld", sharePrinterModel.count];
    [NSString labelString:_shareUserCount font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(canShare.length+1, str.length ) color:systemColor];
    
    [_QRCodeView sd_setImageWithURL:[NSURL URLWithString:sharePrinterModel.img] placeholderImage:nil];
    
}

@end
