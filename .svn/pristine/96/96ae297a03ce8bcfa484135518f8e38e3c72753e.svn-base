//
//  TMXPrinteringStatusCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/9/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinteringStatusCell.h"
#import "TMXAccountPrintTaskModel.h"

@interface TMXPrinteringStatusCell()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *modelNameLab;
@property (nonatomic, strong) UILabel *statusLab;
@property (nonatomic, strong) UIImageView *timeIcon;
@property (nonatomic, strong) UIProgressView *timeProgress;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *leastTimeLab;
@property (nonatomic, strong) UIImageView *tempetatureIcon;
@property (nonatomic, strong) UIProgressView *tempetatureProgress;
@property (nonatomic, strong) UILabel *tempetatureLab;

@property (nonatomic, strong) UIButton *switchWireBtn;
@property (nonatomic, strong) UIButton *stopBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation TMXPrinteringStatusCell

#pragma mark <lazyLoad>

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _icon;
}


-(UILabel *)modelNameLab{
    if (!_modelNameLab) {
        _modelNameLab=[UILabel new];
        _modelNameLab.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _modelNameLab;
}


-(UILabel *)statusLab{
    if (!_statusLab) {
        _statusLab=[UILabel new];
        _statusLab.font = [UIFont systemFontOfSize:12*AppScale];
        _statusLab.textColor = systemColor;
    }
    return _statusLab;
}

-(UIImageView *)timeIcon{
    if (!_timeIcon) {
        _timeIcon=[UIImageView new];
        _timeIcon.image = [UIImage imageNamed:@"PrinteringIcon"];
    }
    return _timeIcon;
}

-(UIProgressView *)timeProgress{
    if (!_timeProgress) {
        _timeProgress=[UIProgressView new];
        _timeProgress.layer.cornerRadius=3.0*AppScale;
        _timeProgress.layer.masksToBounds=YES;
        _timeProgress.progressTintColor=systemColor;
    }
    return _timeProgress;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[UILabel new];
        _timeLab.font = [UIFont systemFontOfSize:11*AppScale];
    }
    return _timeLab;
}

-(UILabel *)leastTimeLab{
    if (!_leastTimeLab) {
        _leastTimeLab=[UILabel new];
        _leastTimeLab.font = [UIFont systemFontOfSize:11*AppScale];
    }
    return _leastTimeLab;
}

-(UIImageView *)tempetatureIcon{
    if (!_tempetatureIcon) {
        _tempetatureIcon=[UIImageView new];
        _tempetatureIcon.image = [UIImage imageNamed:@"TemIcon"];
    }
    return _tempetatureIcon;
}

-(UIProgressView *)tempetatureProgress{
    if (!_tempetatureProgress) {
        _tempetatureProgress=[UIProgressView new];
        _tempetatureProgress.layer.cornerRadius=3.0*AppScale;
        _tempetatureProgress.layer.masksToBounds=YES;
        _tempetatureProgress.progressTintColor=systemColor;
    }
    return _tempetatureProgress;
}
-(UILabel *)tempetatureLab{
    if (!_tempetatureLab) {
        _tempetatureLab=[UILabel new];
        _tempetatureLab.text = NSLocalizedString(@"Tem", nil);
        _tempetatureLab.font = [UIFont systemFontOfSize:11*AppScale];
    }
    return _tempetatureLab;
}

-(UIButton *)switchWireBtn{
    if (!_switchWireBtn) {
        _switchWireBtn=[UIButton buttonWithType:0];
        [_switchWireBtn addTarget:self action:@selector(touchSwitchBtn:) forControlEvents:UIControlEventTouchUpInside];
        _switchWireBtn.backgroundColor = systemColor;
        _switchWireBtn.layer.cornerRadius = 5*AppScale;
        _switchWireBtn.layer.masksToBounds = YES;
        [_switchWireBtn setTitle:NSLocalizedString(@"Change", nil) forState:UIControlStateNormal];
        [_switchWireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_switchWireBtn setImage:[UIImage imageNamed:@"ChangeSilk"] forState:UIControlStateNormal];
        _switchWireBtn.titleLabel.font = [UIFont systemFontOfSize:11*AppScale];
        _switchWireBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8*AppScale);
        
    }
    return _switchWireBtn;
}

-(UIButton *)stopBtn{
    if (!_stopBtn) {
        _stopBtn=[UIButton buttonWithType:0];
        [_stopBtn addTarget:self action:@selector(touchStopBtn:) forControlEvents:UIControlEventTouchUpInside];
        _stopBtn.backgroundColor = systemColor;
        _stopBtn.layer.cornerRadius = 5*AppScale;
        _stopBtn.layer.masksToBounds = YES;
        [_stopBtn setTitle:NSLocalizedString(@"Stop_Resume", nil) forState:UIControlStateNormal];
        [_stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_stopBtn setImage:[UIImage imageNamed:@"RecoveryIcon"] forState:UIControlStateNormal];
        _stopBtn.titleLabel.font = [UIFont systemFontOfSize:11*AppScale];
        _stopBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8*AppScale);
    }
    return _stopBtn;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn=[UIButton buttonWithType:0];
        [_cancelBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.backgroundColor = systemColor;
        _cancelBtn.layer.cornerRadius = 5*AppScale;
        _cancelBtn.layer.masksToBounds = YES;
        [_cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelBtn setImage:[UIImage imageNamed:@"CancelIcon"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:11*AppScale];
        _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8*AppScale);
    }
    return _cancelBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.modelNameLab];
    [self addSubview:self.statusLab];
    [self addSubview:self.timeIcon];
    [self addSubview:self.timeProgress];
    [self addSubview:self.timeLab];
    [self addSubview:self.leastTimeLab];
    [self addSubview:self.tempetatureIcon];
    [self addSubview:self.tempetatureProgress];
    [self addSubview:self.tempetatureLab];
    [self addSubview:self.switchWireBtn];
    [self addSubview:self.stopBtn];
    [self addSubview:self.cancelBtn];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(5*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 120*AppScale));
    }];
    
    [_modelNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_top);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-5*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
    
    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_modelNameLab.mas_bottom).with.offset(10*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-5*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
    
    [_timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statusLab.mas_bottom).with.offset(7*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.size.mas_equalTo(CGSizeMake(13*AppScale, 13*AppScale));
    }];
    
    [_timeProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timeIcon.mas_centerY);
        make.left.equalTo(_timeIcon.mas_right).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-5*AppScale);
        make.height.mas_equalTo(@(10*AppScale));
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeIcon.mas_bottom).with.offset(7*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.right.equalTo(_leastTimeLab.mas_left);
        make.height.mas_equalTo(@(13*AppScale));
        make.width.mas_equalTo((SCREENWIDTH-110)/2);
    }];
    
    [_leastTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeIcon.mas_bottom).with.offset(7*AppScale);
        make.left.equalTo(_timeLab.mas_right);
        make.right.equalTo(weakSelf.mas_right).with.offset(-5*AppScale);
        make.height.mas_equalTo(@(13*AppScale));
        make.width.mas_equalTo((SCREENWIDTH-110)/2);
    }];
    
    
    [_tempetatureIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLab.mas_bottom).with.offset(10*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.size.mas_equalTo(CGSizeMake(13*AppScale, 13*AppScale));
    }];
    
    [_tempetatureProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_tempetatureIcon.mas_centerY);
        make.left.equalTo(_tempetatureIcon.mas_right).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-5*AppScale);
        make.height.mas_equalTo(@(10*AppScale));
        
    }];
    
    [_tempetatureLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tempetatureIcon.mas_bottom).with.offset(7*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-5*AppScale);
        make.height.mas_equalTo(@(13*AppScale));
        make.width.mas_equalTo((SCREENWIDTH-110)/2);
    }];
    
    [_switchWireBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
        make.top.equalTo(_icon.mas_bottom).with.offset(15*AppScale);
        make.height.mas_equalTo(@(25*AppScale));
        make.width.mas_equalTo(@((SCREENWIDTH-80*AppScale)/3));
    }];
    
    [_stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_switchWireBtn.mas_right).with.offset(20*AppScale);
        make.top.equalTo(_icon.mas_bottom).with.offset(15*AppScale);
        make.height.mas_equalTo(@(25*AppScale));
        make.width.mas_equalTo(@((SCREENWIDTH-80*AppScale)/3));
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*AppScale);
        make.top.equalTo(_icon.mas_bottom).with.offset(15*AppScale);
        make.height.mas_equalTo(@(25*AppScale));
        make.width.mas_equalTo(@((SCREENWIDTH-80*AppScale)/3));
    }];
    
}


#pragma mark <otherResponse>
-(void)touchSwitchBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(printerSwitchWire)]) {
        [self.delegate printerSwitchWire];
    }
}

-(void)touchStopBtn:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"Stop", nil)]) {
        
        [_stopBtn setTitle:NSLocalizedString(@"Restore", nil) forState:UIControlStateNormal];
        [_stopBtn setImage:[UIImage imageNamed:@"startTask"] forState:0];
        if (self.delegate && [self.delegate respondsToSelector:@selector(printerResume)]) {
            [self.delegate printerResume];
        }
        
    }else{
        
        [_stopBtn setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateNormal];
        [_stopBtn setImage:[UIImage imageNamed:@"RecoveryIcon"] forState:0];
        if (self.delegate && [self.delegate respondsToSelector:@selector(printerPause)]) {
            [self.delegate printerPause];
        }
    }
}


-(void)touchCancelBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(printerCancel)]) {
        [self.delegate printerCancel];
    }
}


#pragma mark <getter setter>
-(void)setTMXAccountPrintTaskModel:(TMXAccountPrintTaskModel *)tMXAccountPrintTaskModel{
    
    _tMXAccountPrintTaskModel=tMXAccountPrintTaskModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:tMXAccountPrintTaskModel.modelImage] placeholderImage:nil];
    _modelNameLab.text=tMXAccountPrintTaskModel.modelName;
    
    if (tMXAccountPrintTaskModel.msgContent.length==0) {
        _statusLab.text=tMXAccountPrintTaskModel.status;
    }else{
        _statusLab.text=tMXAccountPrintTaskModel.msgContent;
    }
    
    //判断是否暂停
    if (tMXAccountPrintTaskModel.usedSeconds.length == 0 && tMXAccountPrintTaskModel.totalSeconds.length == 0) {
        _timeLab.text = NSLocalizedString(@"Time_Stop", nil);
    }else
    {
        
        NSInteger useMin=[tMXAccountPrintTaskModel.usedSeconds integerValue];
        NSInteger totalMin=[tMXAccountPrintTaskModel.totalSeconds integerValue];
        if (useMin%60==0) {
            useMin=useMin/60;
        }else{
            useMin=useMin/60+1;
        }
        
        if (totalMin%60==0) {
            totalMin=totalMin/60;
        }else{
            totalMin=totalMin/60+1;
        }
        NSString *tim = NSLocalizedString(@"Time", nil);
        NSString *minute = NSLocalizedString(@"Minu", nil);
        NSString *modelTime=[NSString stringWithFormat:@"%@%ld/%ld%@",tim,useMin,totalMin,minute];
        _timeLab.text=modelTime;
    }
    
    if (tMXAccountPrintTaskModel.leftSeconds.length == 0) {
        
        if (_isHasTask) {
            _leastTimeLab.text = NSLocalizedString(@"Unknown", nil);
        }else{
            _leastTimeLab.text=NSLocalizedString(@"Remain_Zero", nil);
            
        }
    }else
    {
        
        NSInteger remainMin=[tMXAccountPrintTaskModel.leftSeconds integerValue];
        if (remainMin%60==0) {
            remainMin=remainMin/60;
        }else{
            remainMin=remainMin/60+1;
        }
        NSString *main = NSLocalizedString(@"Remain", nil);
        NSString *minute = NSLocalizedString(@"Minu", nil);
        NSString *remainString=[NSString stringWithFormat:@"%@ %ld%@",main,remainMin, minute];
        _leastTimeLab.text=remainString;
    }
    
    if (tMXAccountPrintTaskModel.currentTemperature.length == 0 && tMXAccountPrintTaskModel.expectedTemperature.length == 0) {
        _tempetatureLab.text = NSLocalizedString(@"Tem", nil);
    }else
    {
        
        
        NSString *currentTemperature;
        NSString *expectedTemperature;
        
        if (tMXAccountPrintTaskModel.currentTemperature.length==0) {
            currentTemperature=@"0";
        }else{
            currentTemperature=[NSString stringWithFormat:@"%@",tMXAccountPrintTaskModel.currentTemperature];
        }
        if (tMXAccountPrintTaskModel.expectedTemperature.length==0) {
            expectedTemperature=@"0";
        }else{
            expectedTemperature=[NSString stringWithFormat:@"%@",tMXAccountPrintTaskModel.expectedTemperature];
        }
        NSString *temp = NSLocalizedString(@"Tem", nil);
        NSString *temperatureString=[NSString stringWithFormat:@"%@ %@℃/%@℃",temp,currentTemperature,expectedTemperature];
        _tempetatureLab.text=temperatureString;
    }
    
    //完成度
    _timeProgress.progress=[tMXAccountPrintTaskModel.completion floatValue]/100;
    _tempetatureProgress.progress=[tMXAccountPrintTaskModel.currentTemperature floatValue]/[tMXAccountPrintTaskModel.expectedTemperature floatValue];
}

-(void)setTMXAccountUpdatePrintTaskModel:(TMXAccountUpdatePrintTaskModel *)tMXAccountUpdatePrintTaskModel{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:tMXAccountUpdatePrintTaskModel.modelImage] placeholderImage:nil];
    _modelNameLab.text=tMXAccountUpdatePrintTaskModel.modelName;
    
    _tMXAccountUpdatePrintTaskModel=tMXAccountUpdatePrintTaskModel;
    
    if (tMXAccountUpdatePrintTaskModel.msgContent.length==0) {
        _statusLab.text=tMXAccountUpdatePrintTaskModel.status;
    }else{
        _statusLab.text=tMXAccountUpdatePrintTaskModel.msgContent;
    }
    
    //    self.printerState.text=tMXAccountUpdatePrintTaskModel.status;
    
    //判断是否暂停
    if (tMXAccountUpdatePrintTaskModel.usedSeconds.length == 0 && tMXAccountUpdatePrintTaskModel.totalSeconds.length == 0) {
        _timeLab.text = NSLocalizedString(@"Time_Stop", nil);
    }else
    {
        
        NSInteger useMin=[tMXAccountUpdatePrintTaskModel.usedSeconds integerValue];
        NSInteger totalMin=[tMXAccountUpdatePrintTaskModel.totalSeconds integerValue];
        if (useMin%60==0) {
            useMin=useMin/60;
        }else{
            useMin=useMin/60+1;
        }
        
        if (totalMin%60==0) {
            totalMin=totalMin/60;
        }else{
            totalMin=totalMin/60+1;
        }
        NSString *tim = NSLocalizedString(@"Time", nil);
        NSString *minu = NSLocalizedString(@"Minu", nil);
        NSString *modelTime=[NSString stringWithFormat:@"%@ %ld/%ld%@",tim,useMin,totalMin,minu];
        _timeLab.text=modelTime;
        
    }
    
    if (tMXAccountUpdatePrintTaskModel.leftSeconds.length == 0) {
        _leastTimeLab.text = NSLocalizedString(@"Unknown", nil);
    }else
    {
        
        NSInteger remainMin=[tMXAccountUpdatePrintTaskModel.leftSeconds integerValue];
        if (remainMin%60==0) {
            remainMin=remainMin/60;
        }else{
            remainMin=remainMin/60+1;
        }
        NSString *mai = NSLocalizedString(@"Remain", nil);
        NSString *minu = NSLocalizedString(@"Minu", nil);
        NSString *remainString=[NSString stringWithFormat:@"%@ %ld%@",mai,remainMin,minu];
        _leastTimeLab.text=remainString;
    }
    
    if (tMXAccountUpdatePrintTaskModel.currentTemperature.length == 0 && tMXAccountUpdatePrintTaskModel.expectedTemperature.length == 0) {
        _tempetatureLab.text = NSLocalizedString(@"Tem", nil);;
    }else
    {
        
        NSString *currentTemperature;
        NSString *expectedTemperature;
        
        if (tMXAccountUpdatePrintTaskModel.currentTemperature.length==0) {
            currentTemperature=@"0";
        }else{
            currentTemperature=[NSString stringWithFormat:@"%@",tMXAccountUpdatePrintTaskModel.currentTemperature];
        }
        if (tMXAccountUpdatePrintTaskModel.expectedTemperature.length==0) {
            expectedTemperature=@"0";
        }else{
            expectedTemperature=[NSString stringWithFormat:@"%@",tMXAccountUpdatePrintTaskModel.expectedTemperature];
        }
        NSString *temp = NSLocalizedString(@"Tem", nil);
        NSString *temperatureString=[NSString stringWithFormat:@"%@ %@℃/%@℃",temp,currentTemperature,expectedTemperature];
        _tempetatureLab.text=temperatureString;
    }
    
    self.timeProgress.progress=[tMXAccountUpdatePrintTaskModel.completion floatValue]/100;
    self.tempetatureProgress.progress=[tMXAccountUpdatePrintTaskModel.currentTemperature floatValue]/[tMXAccountUpdatePrintTaskModel.expectedTemperature floatValue];
    
}
    
-(void)setIsHasTask:(BOOL)isHasTask{
    _isHasTask=isHasTask;
}

-(void)setIsAll:(BOOL)isAll{
    _isAll=isAll;
    if (_isAll) {
        
        _switchWireBtn.userInteractionEnabled=NO;
        _stopBtn.userInteractionEnabled=NO;
        _cancelBtn.userInteractionEnabled=NO;
        _switchWireBtn.backgroundColor=[UIColor lightGrayColor];
        _stopBtn.backgroundColor=[UIColor lightGrayColor];
        _cancelBtn.backgroundColor=[UIColor lightGrayColor];
        
    }else{
        
        if (_isHasTask) {
            //暂停按钮可以使用
            _stopBtn.backgroundColor=systemColor;
            _stopBtn.userInteractionEnabled=YES;
            
            if (_isPausedTask) {
                _switchWireBtn.userInteractionEnabled=YES;
                _switchWireBtn.backgroundColor=RGBColor(237, 108, 0);
                
                [_stopBtn setTitle:NSLocalizedString(@"Restore", nil) forState:UIControlStateNormal];
                //开始
                [_stopBtn setImage:[UIImage imageNamed:@"startTask"] forState:0];
                
            }else{
                
                _switchWireBtn.userInteractionEnabled=NO;
                _switchWireBtn.backgroundColor=[UIColor lightGrayColor];
                
                [_stopBtn setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateNormal];
                //暂停
                [_stopBtn setImage:[UIImage imageNamed:@"RecoveryIcon"] forState:0];
            }
            
        }else{
            _switchWireBtn.userInteractionEnabled=YES;
            _switchWireBtn.backgroundColor=RGBColor(237, 108, 0);
            [_stopBtn setTitle:NSLocalizedString(@"Restore", nil) forState:UIControlStateNormal];
            //开始
            [_stopBtn setImage:[UIImage imageNamed:@"startTask"] forState:0];
            _stopBtn.backgroundColor=systemColor;
            _stopBtn.userInteractionEnabled=YES;
        }
         _cancelBtn.backgroundColor=systemColor;
         _cancelBtn.userInteractionEnabled=YES;
         [_cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    }
    
}

-(void)setIsPausedTask:(BOOL)isPausedTask{
    
    _isPausedTask=isPausedTask;
}


@end
