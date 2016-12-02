//
//  TMXControllerCenterSetupVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXControllerCenterSetupVC.h"
#import "TMXGetPrinterSateModel.h"

@interface TMXControllerCenterSetupVC ()<UIAlertViewDelegate>
{
    TMXGetPrinterSateModel *getStateModel;           ///<获取状态
    NSMutableDictionary *params;
    
    TMXUpEnergySavingStateModel *upEnergyModel;     ///<修改情感灯光节能
    NSMutableDictionary *upEnergyParams;
    
    TMXUpInductionDoorStateModel *doorModel;        ///<修改安全门自动感应状态
    NSMutableDictionary *doorParams;
    
    TMXCheckVersionModel *checkVersionModel;        ///<检测是否为最新版本
    NSMutableDictionary *checkParams;
    MBProgressHUD *hud;

}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view1Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *automaticLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *automaticRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *swtchRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *checkBottom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *checkHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *checkTop;


@property (strong, nonatomic) IBOutlet UILabel *automatic;
@property (strong, nonatomic) IBOutlet UILabel *noTurnOff;
@property (strong, nonatomic) IBOutlet UISwitch *energyState;
@property (strong, nonatomic) IBOutlet UISwitch *doorState;
@property (strong, nonatomic) IBOutlet UILabel *versions;
@property (strong, nonatomic) IBOutlet UIButton *checkUpdate;

@end

@implementation TMXControllerCenterSetupVC

//修改
- (void)modify
{
    self.checkBottom.constant = 40*AppScale;
    self.checkHeight.constant = 35*AppScale;
    self.checkTop.constant = 5*AppScale;
    self.versions.font = [UIFont systemFontOfSize:12*AppScale];
    self.checkUpdate.layer.cornerRadius = 5*AppScale;
    self.checkUpdate.layer.masksToBounds = YES;
    self.checkUpdate.titleLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.describeTop.constant = 64+20*AppScale;
    self.view1Height.constant = 40*AppScale;
    self.automaticLeft.constant = 15*AppScale;
    self.automaticRight.constant = 15*AppScale;
    self.swtchRight.constant = 15*AppScale;
    self.automatic.font = [UIFont systemFontOfSize:13*AppScale];
    self.noTurnOff.font = [UIFont systemFontOfSize:13*AppScale];
    self.automatic.text = NSLocalizedString(@"Emotional", nil);
    self.noTurnOff.text = NSLocalizedString(@"Safety", nil);
    NSString *info = NSLocalizedString(@"Version", nil);
    self.versions.text=info;
    [self.checkUpdate setTitle:NSLocalizedString(@"Check_update", nil) forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    [self.navigationItem setTitle:NSLocalizedString(@"Advanced", nil)];
    self.view.backgroundColor = backGroundColor;
    
    getStateModel = [TMXGetPrinterSateModel new];
    params = [NSMutableDictionary dictionary];
    upEnergyModel = [TMXUpEnergySavingStateModel new];
    upEnergyParams = [NSMutableDictionary dictionary];
    doorModel = [TMXUpInductionDoorStateModel new];
    doorParams = [NSMutableDictionary dictionary];
    checkVersionModel = [TMXCheckVersionModel new];
    checkParams = [NSMutableDictionary dictionary];
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor clearColor];
    hud.color=[UIColor clearColor];
    hud.activityIndicatorColor=systemColor;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

#pragma mark - loadData
- (void)loadData
{
    params[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    params[@"printerId"] = @(self.printerId);
    [getStateModel FetchTMXGetPrinterSateModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            getStateModel = result;
            self.energyState.on = getStateModel.energySavingState;
            self.doorState.on = getStateModel.inductionDoorState;
            if (getStateModel.currentVersion.length) {
                NSString *info = NSLocalizedString(@"Version", nil);
                self.versions.text = [NSString stringWithFormat:@"%@%@",info, getStateModel.currentVersion];
            }else
            {
                self.versions.text = NSLocalizedString(@"Version", nil);
            }
            [hud hide:YES];

        }else
        {
            [MBProgressHUD showError:result];
            [hud hide:YES];
        }
    }];
}

//情感灯光节能
- (IBAction)automaticTurnOff:(UISwitch *)sender {
    
    [upEnergyModel FetchTMXUpEnergySavingStateModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}
//安全门自动感应
- (IBAction)putOutLamp:(UISwitch *)sender {
    doorParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    doorParams[@"printerId"] = @(self.printerId);
    if (sender.selected) {
        doorParams[@"status"] = @"true";
    }else
    {
        doorParams[@"status"] = @"false";
    }
    [doorModel FetchTMXUpInductionDoorStateModel:doorParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
    
}

//检查更新
- (IBAction)checkUpdate:(UIButton *)sender {
    
    checkParams[@"currentVersion"] = getStateModel.currentVersion;
    [checkVersionModel FetchTMXCheckVersionModel:checkParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            checkVersionModel = result;
            if (checkVersionModel.result) {
                [self lastVersion];
            }else
            {
                [self upLoadVersion];
            }
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//检测已经是最新版本
- (void)lastVersion
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Latest_version", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Confirm", nil) otherButtonTitles: nil];
    [UIView appearance].tintColor = systemColor;
    [alertView show];
}

//不是最新版本
- (void)upLoadVersion
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Check_latest", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Upload_version", nil),  nil];
    [UIView appearance].tintColor = systemColor;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"下载");
    }
}

#pragma mark - setter getter
-(void)setPrinterId:(NSInteger)printerId
{
    _printerId = printerId;
}

@end
