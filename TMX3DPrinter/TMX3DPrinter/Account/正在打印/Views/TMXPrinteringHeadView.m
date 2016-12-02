//
//  TMXPrinteringHeadView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinteringHeadView.h"
#import "TMXAccountPrintTaskModel.h"
#import "TMXAccountPrinterCommandModel.h"


@interface TMXPrinteringHeadView ()

{
    TMXAccountPrinterCommandModel *tMXAccountPrinterCommandModel;
    NSMutableDictionary *params;
    BOOL isStop;
    
}

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *firstViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *secondViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *thirdViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *fourViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *stateHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *timeWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *timeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *temHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view2Left;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view3Left;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view3Right;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *printerIconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *printerIconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *temIconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *temIconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *printerSpeedHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backHeight;



@property (strong, nonatomic) IBOutlet NSLayoutConstraint *temSpeedHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *printerSpeedTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *temSpeedTop;



@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *remain;
@property (strong, nonatomic) IBOutlet UILabel *temperature;
@property (strong, nonatomic) IBOutlet UIProgressView *speedProgress;       ///<速度
@property (strong, nonatomic) IBOutlet UIProgressView *temperatureProgress;   ///<温度
@property (strong, nonatomic) IBOutlet UIButton *exchangeButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *modelName;


@property (weak, nonatomic) IBOutlet UILabel *printerState;
- (IBAction)huansiButton:(id)sender;
- (IBAction)pauseButton:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end

@implementation TMXPrinteringHeadView

//修改
- (void)modify
{
    [self.exchangeButton setTitle:@"换丝" forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.exchangeButton setTitle:@"换丝" forState:UIControlStateSelected];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateSelected];
    self.backHeight.constant = 175*AppScale;
    self.iconWidth.constant = 100*AppScale;
    self.iconHeight.constant = 120*AppScale;
    self.firstViewHeight.constant = 80*AppScale;
    self.secondViewHeight.constant = 40*AppScale;
    self.thirdViewHeight.constant = 30*AppScale;
    self.fourViewHeight.constant = 30*AppScale;
    self.nameHeight.constant = 15*AppScale;
    self.stateHeight.constant = 15*AppScale;
    self.timeWidth.constant = 100*AppScale;
    self.timeHeight.constant = 15*AppScale;
    self.temHeight.constant = 15*AppScale;
    self.printerIconWidth.constant = 18*AppScale;
    self.printerIconHeight.constant = 18*AppScale;
    self.viewLeft.constant = 20*AppScale;
    self.view2Left.constant = 20*AppScale;
    self.view3Left.constant = 20*AppScale;
    self.view3Right.constant = 20*AppScale;
    self.temIconWidth.constant = 18*AppScale;
    self.temIconHeight.constant = 18*AppScale;
    self.printerSpeedHeight.constant = 8*AppScale;
    self.temSpeedHeight.constant = 8*AppScale;
    self.printerSpeedTop.constant = 10*AppScale;
    self.temSpeedTop.constant = 11*AppScale;
}

-(void)awakeFromNib
{
    [self modify];
//    self.fileList.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor whiteColor];
    self.printerState.textColor=[UIColor orangeColor];
    
    //修改属性
    self.speedProgress.layer.cornerRadius = 5.0;
    self.speedProgress.layer.masksToBounds = YES;
    self.speedProgress.progressTintColor=[UIColor orangeColor];
    self.speedProgress.progress=0.0;
    
    self.temperatureProgress.layer.cornerRadius = 5.0;
    self.temperatureProgress.layer.masksToBounds = YES;
    self.temperatureProgress.progressTintColor=[UIColor orangeColor];
    self.temperatureProgress.progress=0.0;
    
    
    self.exchangeButton.layer.cornerRadius = 5.0;
    self.exchangeButton.layer.masksToBounds = YES;
    self.stopButton.layer.cornerRadius = 5.0;
    self.stopButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = 5.0;
    self.cancelButton.layer.masksToBounds = YES;
    
    self.icon.contentMode=UIViewContentModeScaleAspectFit;
    tMXAccountPrinterCommandModel=[[TMXAccountPrinterCommandModel alloc]init];
    params=[NSMutableDictionary dictionary];
    params[@"length"]=@(1);
    params[@"temperature"]=@(80);
    
    
    isStop=YES;
}

-(void)setTMXAccountPrintTaskModel:(TMXAccountPrintTaskModel *)tMXAccountPrintTaskModel{
    
    _tMXAccountPrintTaskModel=tMXAccountPrintTaskModel;
//    params[@"printerId"]=tMXAccountPrintTaskModel.printerId;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:tMXAccountPrintTaskModel.modelImage] placeholderImage:nil];
    self.modelName.text=tMXAccountPrintTaskModel.modelName;
    
    if (tMXAccountPrintTaskModel.msgContent.length==0) {
         self.printerState.text=tMXAccountPrintTaskModel.status;
    }else{
        self.printerState.text=tMXAccountPrintTaskModel.msgContent;
    }
    
    //判断是否暂停
    if (tMXAccountPrintTaskModel.usedSeconds.length == 0 && tMXAccountPrintTaskModel.totalSeconds.length == 0) {
        self.time.text = @"时间:0/0分";
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
        
        NSString *modelTime=[NSString stringWithFormat:@"时间: %ld/%ld分",useMin,totalMin];
        self.time.text=modelTime;
    }
    
    if (tMXAccountPrintTaskModel.leftSeconds.length == 0) {
        
        if (_isHasTask) {
            self.remain.text = @"剩余:未知";
        }else{
            self.remain.text=@"剩余:0分";

        }
    }else
    {
        
        NSInteger remainMin=[tMXAccountPrintTaskModel.leftSeconds integerValue];
        if (remainMin%60==0) {
            remainMin=remainMin/60;
        }else{
            remainMin=remainMin/60+1;
        }
        
        NSString *remainString=[NSString stringWithFormat:@"剩余: %ld分",remainMin];
        self.remain.text=remainString;
    }
    
    if (tMXAccountPrintTaskModel.currentTemperature.length == 0 && tMXAccountPrintTaskModel.expectedTemperature.length == 0) {
        self.temperature.text = @"温度:";
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

        NSString *temperatureString=[NSString stringWithFormat:@"温度: %@/%@C",currentTemperature,expectedTemperature];
        self.temperature.text=temperatureString;
    }
    
    //完成度
    self.speedProgress.progress=[tMXAccountPrintTaskModel.completion floatValue]/100;
    self.temperatureProgress.progress=[tMXAccountPrintTaskModel.currentTemperature floatValue]/[tMXAccountPrintTaskModel.expectedTemperature floatValue];
}

-(void)setTMXAccountUpdatePrintTaskModel:(TMXAccountUpdatePrintTaskModel *)tMXAccountUpdatePrintTaskModel{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:tMXAccountUpdatePrintTaskModel.modelImage] placeholderImage:nil];
    self.modelName.text=tMXAccountUpdatePrintTaskModel.modelName;
    
    _tMXAccountUpdatePrintTaskModel=tMXAccountUpdatePrintTaskModel;
    params[@"printerId"]=tMXAccountUpdatePrintTaskModel.printerId;
    
    if (tMXAccountUpdatePrintTaskModel.msgContent.length==0) {
        self.printerState.text=tMXAccountUpdatePrintTaskModel.status;
    }else{
        self.printerState.text=tMXAccountUpdatePrintTaskModel.msgContent;
    }
    
//    self.printerState.text=tMXAccountUpdatePrintTaskModel.status;
    
    //判断是否暂停
    if (tMXAccountUpdatePrintTaskModel.usedSeconds.length == 0 && tMXAccountUpdatePrintTaskModel.totalSeconds.length == 0) {
        self.time.text = @"时间:0/0分";
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
        
        NSString *modelTime=[NSString stringWithFormat:@"时间: %ld/%ld分",useMin,totalMin];
        self.time.text=modelTime;

    }
    
    if (tMXAccountUpdatePrintTaskModel.leftSeconds.length == 0) {
        self.remain.text = @"剩余:未知";
    }else
    {
        
        NSInteger remainMin=[tMXAccountUpdatePrintTaskModel.leftSeconds integerValue];
        if (remainMin%60==0) {
            remainMin=remainMin/60;
        }else{
            remainMin=remainMin/60+1;
        }
        NSString *remainString=[NSString stringWithFormat:@"剩余: %ld分",remainMin];
        self.remain.text=remainString;
    }
    
    if (tMXAccountUpdatePrintTaskModel.currentTemperature.length == 0 && tMXAccountUpdatePrintTaskModel.expectedTemperature.length == 0) {
        self.temperature.text = @"温度:";
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
        
        NSString *temperatureString=[NSString stringWithFormat:@"温度: %@/%@C",currentTemperature,expectedTemperature];
        self.temperature.text=temperatureString;
    }
    
    self.speedProgress.progress=[tMXAccountUpdatePrintTaskModel.completion floatValue]/100;
    self.temperatureProgress.progress=[tMXAccountUpdatePrintTaskModel.currentTemperature floatValue]/[tMXAccountUpdatePrintTaskModel.expectedTemperature floatValue];
    
}

- (IBAction)huansiButton:(id)sender {
//    params[@"command"]=@(2);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(huansiPrinter)]) {
        [self.delegate huansiPrinter];
    }
    
//    [tMXAccountPrinterCommandModel FetchTMXAccountPrinterCommandData:params callBack:^(BOOL isSuccess, id result) {
//        
//        if (isSuccess) {
//            
//            [MBProgressHUD showSuccess:@"success"];
//        }else{
//            [MBProgressHUD showError:result];
//        }
//    }];
}


- (IBAction)pauseButton:(id)sender {
//    params[@"command"]=@(0);
//    [tMXAccountPrinterCommandModel FetchTMXAccountPrinterCommandData:params callBack:^(BOOL isSuccess, id result) {
//        
//        if (isSuccess) {
//            
//            
//            if (isStop)
//            {
//                isStop=NO;
//                [self.stopButton setTitle:@"恢复" forState:UIControlStateNormal];
//                if (self.delegate && [self.delegate respondsToSelector:@selector(pausePrinterState)]) {
//                    [self.delegate pausePrinterState];
//                }
//                
//            }else
//            {
//                isStop=YES;
//                [self.stopButton setTitle:@"暂停" forState:UIControlStateNormal];
//                if (self.delegate && [self.delegate respondsToSelector:@selector(resumePrinterState)]) {
//                    [self.delegate resumePrinterState];
//                }
//            }
//            [MBProgressHUD showSuccess:@"success"];
//        }else{
//            [MBProgressHUD showError:result];
//        }
//    }];
    
    if ([((UIButton *)sender).titleLabel.text isEqualToString:@"暂停"]) {
        
        [self.stopButton setTitle:@"恢复" forState:UIControlStateNormal];
        [self.stopButton setImage:[UIImage imageNamed:@"startTask"] forState:0];
        if (self.delegate && [self.delegate respondsToSelector:@selector(resumePrinterState)]) {
            [self.delegate resumePrinterState];
        }
        
    }else{
        
        [self.stopButton setTitle:@"暂停" forState:UIControlStateNormal];
        [self.stopButton setImage:[UIImage imageNamed:@"RecoveryIcon"] forState:0];
        if (self.delegate && [self.delegate respondsToSelector:@selector(pausePrinterState)]) {
            [self.delegate pausePrinterState];
        }
    }
}

- (IBAction)cancelButton:(id)sender {
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelPrinterState)]) {
        [self.delegate cancelPrinterState];
    }
//     params[@"command"]=@(1);
//    [tMXAccountPrinterCommandModel FetchTMXAccountPrinterCommandData:params callBack:^(BOOL isSuccess, id result) {
//        
//        if (isSuccess) {
//            
//            [MBProgressHUD showSuccess:@"success"];
//        }else{
//            [MBProgressHUD showError:result];
//        }
//    }];
}



#pragma mark <getter setter>
-(void)setIsHasTask:(BOOL)isHasTask{
    _isHasTask=isHasTask;
#warning 正在打印任务是不允许换丝的
    if (isHasTask) {
//        self.remain.text = @"剩余:0分";
        self.exchangeButton.userInteractionEnabled=NO;
//        [self.exchangeButton setBackgroundImage:[UIImage imageNamed:@"huaiEnable"] forState:0];
        self.exchangeButton.backgroundColor=[UIColor lightGrayColor];
    }else{
        self.exchangeButton.userInteractionEnabled=YES;
//        [self.exchangeButton setBackgroundImage:[UIImage imageNamed:@"huaiState"] forState:0];
        self.exchangeButton.backgroundColor=RGBColor(237, 108, 0);
    }
}

-(void)setIsPausedTask:(BOOL)isPausedTask{
    
    _isPausedTask=isPausedTask;
    if (isPausedTask) {
        [self.stopButton setTitle:@"暂停" forState:UIControlStateNormal];
        [self.stopButton setImage:[UIImage imageNamed:@"RecoveryIcon"] forState:0];
    }else{
        [self.stopButton setTitle:@"恢复" forState:UIControlStateNormal];
        [self.stopButton setImage:[UIImage imageNamed:@"startTask"] forState:0];
    }
}

@end
