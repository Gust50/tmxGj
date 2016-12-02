//
//  TMXPrinterIntoWireVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterIntoWireVC.h"
#import "TMXAccountPrinterCommandModel.h"
#import "TMXMovePaperLocationVC.h"

#define temp NSLocalizedString(@"Tem", nil)

typedef NS_ENUM(NSInteger, PrinterCmd) {
    PrinterPause=0,                 ///<暂停
    PrinterStop,                    ///<停止
    PrinterHuanSi,
    PrinterJinSi,
    PrinterChuSi,
    PrinterX,
    PrinterY,
    PrinterZ,
    PrinterControlTemperature,
    PrinterUrgentStop
};

@interface TMXPrinterIntoWireVC ()
{
    NSMutableDictionary *params;
    TMXAccountPrinterCommandModel *cmdModel;
    CGFloat length;
}

/** 约束 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftConst;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *zConst;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleConst;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *intoConst;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *intoMiddleConst;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *intoLeftConst;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *goWireWidth;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *guideLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *stopLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *guideWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *stopWidth;



@property (strong, nonatomic) IBOutlet UIButton *yCoordinatesAdd;
@property (strong, nonatomic) IBOutlet UIButton *yCoordinatesReduce;
@property (strong, nonatomic) IBOutlet UIButton *xCoordinatesAdd;
@property (strong, nonatomic) IBOutlet UIButton *xCoordinatesReduce;
@property (strong, nonatomic) IBOutlet UIButton *homeButton;
@property (strong, nonatomic) IBOutlet UIButton *zCoordinatesAdd;
@property (strong, nonatomic) IBOutlet UIButton *zCoordinatesReduce;
@property (strong, nonatomic) IBOutlet UIButton *intoWireButton;
@property (strong, nonatomic) IBOutlet UIButton *goWireButton;
@property (strong, nonatomic) IBOutlet UILabel *temperature;
@property (strong, nonatomic) IBOutlet UISlider *temperatureSlider;

@property (nonatomic, assign)PrinterCmd printerCmd;    ///<指令类型

@property (strong, nonatomic) IBOutlet UIButton *imStop;
@property (weak, nonatomic) IBOutlet UIButton *guide;

//add new
@property (strong, nonatomic) IBOutlet UIView *segmentBackgroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentBackground_right;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *segmentBackWidth;
@property (strong, nonatomic) IBOutlet UIButton *left_top_btn;
@property (strong, nonatomic) IBOutlet UIButton *right_top_btn;
@property (strong, nonatomic) IBOutlet UIButton *left_bottom_btn;
@property (strong, nonatomic) IBOutlet UIButton *right_bottom_btn;

@end

@implementation TMXPrinterIntoWireVC

#pragma mark - modify
- (void)modify
{
    
    //add new
    self.segmentBackground_right.constant=25*AppScale;
    
    self.bottomViewHeight.constant = 60*AppScale;
    self.guideWidth.constant = 60*AppScale;
    self.stopWidth.constant = 60*AppScale;
    self.goWireWidth.constant = 70*AppScale;

    self.leftConst.constant = 30*AppScale;
    self.zConst.constant = 10*AppScale;
    self.intoConst.constant = 70*AppScale;
    self.intoMiddleConst.constant = 10*AppScale;
    self.intoLeftConst.constant = 10*AppScale;
    //设置slider的最大最小值
    self.temperatureSlider.minimumValue = [_currenTemperature integerValue];
    self.temperatureSlider.maximumValue = 230;
    self.temperatureSlider.value = 0;
    self.temperatureSlider.continuous=NO;
    
    if (_hasTask) {
    self.temperature.text = [NSString stringWithFormat:@"%@%.0f℃/%.0f℃",temp,self.temperatureSlider.minimumValue, self.temperatureSlider.maximumValue];
    }else{
         self.temperature.text = [NSString stringWithFormat:@"%@%.0f℃/%.0f℃", temp,self.temperatureSlider.value, self.temperatureSlider.maximumValue];
    }
    
    self.temperatureSlider.thumbTintColor=[UIColor orangeColor];
    self.temperatureSlider.minimumTrackTintColor=[UIColor orangeColor];
    
    if (_hasTask) {
        self.yCoordinatesAdd.userInteractionEnabled = NO;
        self.yCoordinatesReduce.userInteractionEnabled = NO;
        self.xCoordinatesAdd.userInteractionEnabled = NO;
        self.xCoordinatesReduce.userInteractionEnabled = NO;
        self.zCoordinatesAdd.userInteractionEnabled = NO;
        self.zCoordinatesReduce.userInteractionEnabled = NO;
        self.homeButton.userInteractionEnabled = NO;
        
        self.intoWireButton.userInteractionEnabled = NO;
        self.goWireButton.userInteractionEnabled = NO;
        self.guide.userInteractionEnabled=NO;
    }else
    {
        self.yCoordinatesAdd.userInteractionEnabled = YES;
        self.yCoordinatesReduce.userInteractionEnabled = YES;
        self.xCoordinatesAdd.userInteractionEnabled = YES;
        self.xCoordinatesReduce.userInteractionEnabled = YES;
        self.zCoordinatesAdd.userInteractionEnabled = YES;
        self.zCoordinatesReduce.userInteractionEnabled = YES;
        self.homeButton.userInteractionEnabled = YES;
        self.intoWireButton.userInteractionEnabled = YES;
        self.goWireButton.userInteractionEnabled = YES;
        self.guide.userInteractionEnabled=YES;
    }
    _left_bottom_btn.selected=NO;
    _right_top_btn.selected=NO;
    _right_bottom_btn.selected=NO;
    _left_top_btn.selected=YES;
    self.guide.titleLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.imStop.titleLabel.font = [UIFont systemFontOfSize:13*AppScale];
    //设置按钮内边距
//    CGFloat heightSpace = 15.0f;
//    CGSize imgViewGuide = self.guide.imageView.bounds.size;
//    CGSize titleGuide = self.guide.titleLabel.bounds.size;
//    CGSize guideSize = self.guide.bounds.size;
//    UIEdgeInsets imageViewGuideEdge = UIEdgeInsetsMake(heightSpace,0.0, guideSize.height -imgViewGuide.height - heightSpace, - titleGuide.width-heightSpace);
//    [self.guide setImageEdgeInsets:imageViewGuideEdge];
//    UIEdgeInsets titleGuideEdge = UIEdgeInsetsMake(imgViewGuide.height +heightSpace, - imgViewGuide.width, 0.0, 0.0);
//    [self.guide setTitleEdgeInsets:titleGuideEdge];
//    
//    CGSize imgViewImStop = self.imStop.imageView.bounds.size;
//    CGSize titleImStop = self.imStop.titleLabel.bounds.size;
//    CGSize imStopSize = self.imStop.bounds.size;
//    UIEdgeInsets imageViewEdge = UIEdgeInsetsMake(heightSpace,0.0, imStopSize.height -imgViewImStop.height - heightSpace, - titleImStop.width-heightSpace);
//    [self.imStop setImageEdgeInsets:imageViewEdge];
//    UIEdgeInsets titleEdge = UIEdgeInsetsMake(imgViewImStop.height +heightSpace, - imgViewImStop.width, 0.0, 0.0);
//    [self.imStop setTitleEdgeInsets:titleEdge];
    
    self.guide.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.imStop.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.guide.imageEdgeInsets = UIEdgeInsetsMake(10*AppScale, 17*AppScale, 30*AppScale, self.guide.titleLabel.bounds.size.width);
    self.guide.titleEdgeInsets = UIEdgeInsetsMake(self.guide.imageView.bounds.size.height+10*AppScale, -self.guide.imageView.bounds.size.width, 0, 0);
    self.imStop.imageEdgeInsets = UIEdgeInsetsMake(10*AppScale, 15*AppScale, 30*AppScale, self.imStop.titleLabel.bounds.size.width);
    self.imStop.titleEdgeInsets = UIEdgeInsetsMake(self.imStop.imageView.bounds.size.height+10*AppScale, -self.imStop.imageView.bounds.size.width, 0, 0);
    
    [self.guide setTitle:NSLocalizedString(@"Level", nil) forState:UIControlStateNormal];
    [self.imStop setTitle:NSLocalizedString(@"Urgency", nil) forState:UIControlStateNormal];
    [self.goWireButton setTitle:NSLocalizedString(@"Withdraw_Filament", nil) forState:UIControlStateNormal];
    [self.intoWireButton setTitle:NSLocalizedString(@"Loading_Filament", nil) forState:UIControlStateNormal];
    
}

#pragma mark <lifeCycel>
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self modify];
    [self.navigationItem setTitle:NSLocalizedString(@"Control", nil)];
    self.view.backgroundColor = backGroundColor;
    [self initData];
    
    self.segmentBackgroundView.backgroundColor=[UIColor clearColor];
}

-(void)initData{
    
    params=[NSMutableDictionary dictionary];
    cmdModel=[[TMXAccountPrinterCommandModel alloc]init];
    length=0.1;
    params[@"temperature"]=_currenTemperature;
    params[@"length"]=@(length);
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

#pragma makr <otherResponse>
//设置温度滑块
- (IBAction)setTemSlider:(UISlider *)sender {
    
    //读取滑块的值
    if (_hasTask) {
        CGFloat min=185.0;
        self.temperatureSlider.minimumValue=min;
        self.temperature.text = [NSString stringWithFormat:@"%@%.0f°C/%.0f°C",temp, min, sender.value];
    }else{
        self.temperatureSlider.minimumValue=[_currenTemperature floatValue];
        self.temperature.text = [NSString stringWithFormat:@"%@%.0f°C/%.0f°C", temp,sender.minimumValue, sender.value];
    }
    params[@"temperature"]=@(sender.value);
    params[@"command"]=@(8);
    [self sendCmd];
}

//点击事件
- (IBAction)setHomeEvent:(UIButton *)sender {
    NSInteger tag = sender.tag;
    switch (tag) {
        case 1:
            params[@"command"]=@(6);
            params[@"length"]=@(length);
            [self sendCmd];
            break;
        case 2:
            params[@"command"]=@(5);
             params[@"length"]=@(length);
             [self sendCmd];
            break;
        case 3:
             params[@"command"]=@(6);
             params[@"length"]=@(-length);
             [self sendCmd];
            break;
        case 4:
            params[@"command"]=@(5);
            params[@"length"]=@(-length);
            [self sendCmd];
            break;
        case 5:
            params[@"command"]=@(10);
            [self sendCmd];
            break;
        case 6:
            params[@"command"]=@(7);
            params[@"length"]=@(length);
            [self sendCmd];
            break;
        case 7:
            params[@"command"]=@(7);
            params[@"length"]=@(-length);
            [self sendCmd];
            break;
        case 8:
            params[@"command"]=@(3);
            params[@"length"]=@(length);
            [self sendCmd];
            break;
        case 9:
             params[@"command"]=@(-1);
             params[@"length"]=@(length);
             [self sendCmd];
             break;
        default:
            break;
    }
}

//打印机指令
-(void)sendCmd{
    
    params[@"printerId"]=_printerId;
     NSLog(@"-------->%@",params);
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=NSLocalizedString(@"Operating", nil);
    [cmdModel FetchTMXAccountPrinterCommandData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess)
        {
            hud.labelText=NSLocalizedString(@"Work_Suc", nil);
            [hud hide:YES afterDelay:1];
        }else
        {
            hud.labelText=NSLocalizedString(@"Work_Fail", nil);
            [hud hide:YES afterDelay:1];
        }
    }];
}

//调平向导
- (IBAction)setLevel:(UIButton *)sender {
    
    TMXMovePaperLocationVC *tMXMovePaperLocationVC=[[TMXMovePaperLocationVC alloc]init];
    tMXMovePaperLocationVC.isHidden=YES;
    tMXMovePaperLocationVC.printerId=_printerId;
    [self.navigationController pushViewController:tMXMovePaperLocationVC animated:YES];
}

//紧急停止
- (IBAction)setStop:(UIButton *)sender {
    params[@"command"]=@(9);
    [self sendCmd];
}

#pragma mark <private method>
- (IBAction)left_top_btn:(UIButton *)sender {
    
    _left_bottom_btn.selected=NO;
    _right_top_btn.selected=NO;
    _right_bottom_btn.selected=NO;
    if (sender.isSelected) {
        
        _left_top_btn.selected=NO;
    }else{
        //选中丝的长度
        length=0.1;
        _left_top_btn.selected=YES;
    }
}

- (IBAction)left_bottom_btn:(UIButton *)sender {
    _left_top_btn.selected=NO;
    _right_top_btn.selected=NO;
    _right_bottom_btn.selected=NO;
    
    if (sender.isSelected) {
        
        _left_bottom_btn.selected=NO;
    }else{
        //选中丝的长度
        length=10;
        _left_bottom_btn.selected=YES;
    }
}
- (IBAction)right_top_btn:(UIButton *)sender {
    _left_top_btn.selected=NO;
    _left_bottom_btn.selected=NO;
    _right_bottom_btn.selected=NO;
    if (sender.isSelected) {
        
        _right_top_btn.selected=NO;
    }else{
        //选中丝的长度
        length=1;
        _right_top_btn.selected=YES;
    }
}

- (IBAction)right_bottom_btn:(UIButton *)sender {
    _left_top_btn.selected=NO;
    _left_bottom_btn.selected=NO;
    _right_top_btn.selected=NO;
    if (sender.isSelected) {
        _right_bottom_btn.selected=NO;
        
    }else{
        //选中丝的长度
        length=100;
        _right_bottom_btn.selected=YES;
    }
}

#pragma mark - setter getter
-(void)setHasTask:(BOOL)hasTask
{
    _hasTask = hasTask;
}

-(void)setPrinterId:(NSString *)printerId{
    _printerId=printerId;
}

-(void)setCurrenTemperature:(NSString *)currenTemperature{
    _currenTemperature=currenTemperature;
}
@end
