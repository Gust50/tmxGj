//
//  TMXNoLinkWifiVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/7/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXNoLinkWifiVC.h"
#import "TMXWiFiConnectionStatusVC.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "TMXAddPrinterModel.h"
#import <AFNetworking.h>

@interface TMXNoLinkWifiVC ()<UIAlertViewDelegate>

{
    TMXAddPrinterApikeyModel *printerApikeyModel;
    TMXAddPrinterModel *addPrinterModel;
    NSUserDefaults *userDefaults;
    NSString *currentWifiName;
}
@property (strong, nonatomic) IBOutlet UIImageView *linkStatus;    ///<连接图标状态
@property (strong, nonatomic) IBOutlet UILabel *wifiName;          ///<显示当前wifi的名称
@property (strong, nonatomic) IBOutlet UIButton *linkPrinter;      ///<点击下一步
@property (nonatomic, assign) NSInteger timeMax;                   ///<请去超时
@property (strong, nonatomic) IBOutlet UILabel *describe;          ///<wiif描述
@property (nonatomic, assign) NSInteger resetTimeMax;              ///<等待打印机重置时间
@property (nonatomic, assign) BOOL isConnecting;                   ///<是否正在连接

@end

@implementation TMXNoLinkWifiVC

#pragma mark <lifeCycle>
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
    if ([[[KBFetchSystemInfo shareInstance] fetchCurrentWIFIName] hasPrefix:@"yeehaw3d_"]) {
        [self.linkPrinter setTitle:NSLocalizedString(@"Connect_printerWi-fi", nil) forState:0];
        [self.linkPrinter setTitleColor:[UIColor whiteColor] forState:0];
        self.linkStatus.image=[UIImage imageNamed:@"LinkWiFiSucIcon"];
        [self.navigationItem setTitle:NSLocalizedString(@"Choose_printerWi-fi", nil)];
    }else{
        [self.linkPrinter setTitleColor:[UIColor whiteColor] forState:0];
        self.linkStatus.image=[UIImage imageNamed:@"NoLinkWiFiIcon"];
        [self.linkPrinter setTitle:NSLocalizedString(@"Next", nil) forState:0];
        [self.navigationItem setTitle:NSLocalizedString(@"Connect_printerWi-fi", nil)];
    }
    self.wifiName.text= [[KBFetchSystemInfo shareInstance]fetchCurrentWIFIName];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[KBGCDTimerManager shareInstance]cancelAllTimerTask];
    [self enableOpenLeftDrawer:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.describe.font = [UIFont systemFontOfSize:11*AppScale];
    self.describe.text = NSLocalizedString(@"Describe", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    self.linkPrinter.layer.cornerRadius = 5.0;
    self.linkPrinter.layer.masksToBounds = YES;
    
    self.isConnecting=NO;
    userDefaults=[NSUserDefaults standardUserDefaults];
    printerApikeyModel=[[TMXAddPrinterApikeyModel alloc]init];
    addPrinterModel=[[TMXAddPrinterModel alloc]init];
    
    //请求次数
    self.timeMax=0;
    
    //检测Wifi的变化
    [[KBGCDTimerManager shareInstance]scheduledDispatchTimerWithName:@"WIFISSID" timeInterval:1.0 queue:nil repeats:YES timerTaskType:removeTimerTaskType action:^{
        if ([[[KBFetchSystemInfo shareInstance]fetchCurrentWIFIName] hasPrefix:@"yeehaw3d_"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_isConnecting) {
                    
                }else{
                     [self dismissAlterVC];
                }
                self.wifiName.text= [[KBFetchSystemInfo shareInstance]fetchCurrentWIFIName];
                self.linkStatus.image=[UIImage imageNamed:@"LinkWiFiSucIcon"];
            });
            
        }else{
            if (_isConnecting) {
                
            }else{
                 [self checkCurrentWIFIStatus];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.wifiName.text= [[KBFetchSystemInfo shareInstance]fetchCurrentWIFIName];
                self.linkStatus.image=[UIImage imageNamed:@"NoLinkWiFiIcon"];
            });
        }
    }];
}

#pragma mark <otherResponse>
//连接打印机热点
- (IBAction)linkHotPrinter:(UIButton *)sender {
    self.isConnecting=YES;
    [[KBGCDTimerManager shareInstance] cancelTimerTaskWithName:@"ConnectPrinterWithTimeout"];
    if ([[[KBFetchSystemInfo shareInstance]fetchCurrentWIFIName] hasPrefix:@"yeehaw3d_"]) {
        //连接打印机WIFI
        [self connectPrinterWithoutSSID];
    }else{
        [self checkCurrentWIFIStatus];
    }
}

#pragma mark <private method>
//不带SSID参数连接打印机
-(void)connectPrinterWithoutSSID{
    
    //第一次连接打印机是不需要发送带参数的请求
    if ([[[KBFetchSystemInfo shareInstance] fetchCurrentWIFIName] hasPrefix:@"yeehaw3d_"]) {
        
        //连接的时候点击下一步按钮显示正在连接状态
        self.linkPrinter.userInteractionEnabled=NO;
        self.linkPrinter.backgroundColor=[UIColor lightGrayColor];
        [self.linkPrinter setTitle:NSLocalizedString(@"Linking_net", nil) forState:UIControlStateNormal];
        self.navigationItem.title=NSLocalizedString(@"Link_net", nil);
        
        //获取apikey请求
        [printerApikeyModel FetchTMXPrinterApikeyData:nil callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess)
            {
                printerApikeyModel=result;
                if ([printerApikeyModel.rc isEqualToString:@"0"])
                {
                    NSString *currentSSID=[userDefaults objectForKey:@"Account"];
                    //如果是重置打印机,首先判断SSID是否和返回回来的SSID一致
                    if ([currentSSID isEqualToString:printerApikeyModel.ssid]) {
                        if (_isResetPrinter) {
                            TMXWiFiConnectionStatusVC *statusVC = [[TMXWiFiConnectionStatusVC alloc] init];
                            statusVC.isResetPrinter=_isResetPrinter;
                            [self.navigationController pushViewController:statusVC animated:YES];
                        }else{
                            [self bindPrinter];
                        }
                        
                    }else{
                        //如果不一致则带参数请求
                        [self connectPrinterWithSSID];
                    }
                }else
                {
                    //这里需要发送带参数的Get请求
                    [self connectPrinterWithSSID];
                    
                }
            }
        }];
    }
    else
    {
        [self checkCurrentWIFIStatus];
        
    }
    
}

//带SSID参数连接打印机
-(void)connectPrinterWithSSID{
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"ssid"]=[userDefaults objectForKey:@"Account"];
    params[@"pwd"]=[userDefaults objectForKey:@"Password"];
    
    if ([[[KBFetchSystemInfo shareInstance] fetchCurrentWIFIName] hasPrefix:@"yeehaw3d_"]) {
        //获取apikey请求
        [printerApikeyModel FetchTMXPrinterApikeyData:params callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess)
            {
                printerApikeyModel=result;
                
                if ([printerApikeyModel.rc isEqualToString:@"0"])
                {
//                    [self bindPrinter];
                    
                }else{
                    
                }
            }
        }];
        //设置请求超时操作
        [[KBGCDTimerManager shareInstance]scheduledDispatchTimerWithName:@"ConnectPrinterWithTimeout" timeInterval:10.0 queue:nil repeats:YES timerTaskType:removeTimerTaskType action:^{
            
            [self fetchPrinterWIFISatus];
        }];
    }
    else
    {
        [self checkCurrentWIFIStatus];
    }
    
}

//重新连接打印机
-(void)retryConnectPrinterWithTimeout{
    //打印机通过SSID连接网络的时间不确定
    [self connectPrinterWithSSID];
}


//绑定打印机
-(void)bindPrinter{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"apiKey"]=printerApikeyModel.printerKey;
    [addPrinterModel FetchTMXAddPrinterData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess)
        {
            addPrinterModel=result;
            TMXWiFiConnectionStatusVC *statusVC = [[TMXWiFiConnectionStatusVC alloc] init];
            statusVC.printerId=addPrinterModel.printerId;
            [self.navigationController pushViewController:statusVC animated:YES];
        }else
        {
            
            UIAlertView *tip=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Results", nil) message:result delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Confirm", nil), nil];
            tip.delegate=self;
            [tip show];
            
            self.linkPrinter.userInteractionEnabled=NO;
            self.linkPrinter.backgroundColor=[UIColor lightGrayColor];
            [self.linkPrinter setTitle:NSLocalizedString(@"LinkNet_Fail", nil) forState:UIControlStateNormal];
            self.navigationItem.title=NSLocalizedString(@"LinkNet_Fail", nil);
        }
        
    }];
}
    
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
    
//获取打印机的连接状态
-(void)fetchPrinterWIFISatus{
    //取消当前的任务
    [[KBHttpTool shareKBHttpToolManager]cancelAllTask];
    _timeMax++;
    self.isConnecting=YES;
    if (_timeMax<6) {
        
        if ([[[KBFetchSystemInfo shareInstance] fetchCurrentWIFIName] hasPrefix:@"yeehaw3d_"]) {
            
            [printerApikeyModel FetchTMXPrinterApikeyData:nil callBack:^(BOOL isSuccess, id result) {
                if (isSuccess) {
                    printerApikeyModel=result;
                    if ([printerApikeyModel.rc isEqualToString:@"0"]) {
                        
                        [[KBGCDTimerManager shareInstance] cancelTimerTaskWithName:@"ConnectPrinterWithTimeout"];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self bindPrinter];
                        });
                        
                    }
                }
            }];

        }else{
            
            //检查当前WIFI的SSID
            [self checkCurrentWIFIStatus];
        }
    }else{
        
        //请求超时的状态
        [[KBGCDTimerManager shareInstance] cancelTimerTaskWithName:@"ConnectPrinterWithTimeout"];
        [self connectTimeOut];
    }
}



/**
 超时操作提示
 */
-(void)connectTimeOut{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.linkPrinter.userInteractionEnabled=NO;
        self.linkPrinter.backgroundColor=[UIColor lightGrayColor];
        [self.linkPrinter setTitle:NSLocalizedString(@"LinkNet_Fail", nil) forState:UIControlStateNormal];
        self.navigationItem.title=NSLocalizedString(@"LinkNet_Fail", nil);
        //是否弹出提示框操作
        
        UIAlertController *alterVC=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"LinkNet_status", nil) message:NSLocalizedString(@"LinkNet_reminder", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"Confirm", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          self.linkPrinter.userInteractionEnabled=YES;
          self.timeMax=0;
          [self.linkPrinter setTitle:NSLocalizedString(@"Connect_printerWi", nil) forState:0];
          [self.linkPrinter setTitleColor:[UIColor whiteColor] forState:0];
          self.linkPrinter.backgroundColor=systemColor;
        }];
        
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle: NSLocalizedString(@"Reset", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alterVC addAction:confirmAction];
        [alterVC addAction:cancelAction];
        [self presentViewController:alterVC animated:YES completion:nil];
    });
}


// 检查当前WIFI的状态
-(void)checkCurrentWIFIStatus{
    //iOS10.0.2之后的版本需要手动设置WIFI,不支持自动跳转
    
    NSString *opera = NSLocalizedString(@"Operation_Select", nil);
//    NSString *showTipStr=[NSString stringWithFormat:@"%@%@%@",current,[[KBFetchSystemInfo shareInstance] fetchCurrentWIFIName],opera];
    UIAlertController *alterVC=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"Wifi_reminder", nil) message:opera preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){.majorVersion = 10, .minorVersion = 0, .patchVersion = 0}]) {}else{
             [self setupWIFI];
        }
    }];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alterVC addAction:confirmAction];
    //        [alterVC addAction:cancelAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alterVC animated:YES completion:nil];
    });

    
    
    
//    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){.majorVersion = 10, .minorVersion = 0, .patchVersion = 0}]) {
//        
//        NSString *current = NSLocalizedString(@"CurrentWifi", nil);
//        NSString *opera = NSLocalizedString(@"Operation_Select", nil);
//        NSString *showTipStr=[NSString stringWithFormat:@"%@%@%@",current,[[KBFetchSystemInfo shareInstance] fetchCurrentWIFIName],opera];
//        UIAlertController *alterVC=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"Wifi_reminder", nil) message:showTipStr preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"Confirm", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        
//        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        
//        [alterVC addAction:confirmAction];
////        [alterVC addAction:cancelAction];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//              [self presentViewController:alterVC animated:YES completion:nil];
//        });
//      
//        
//    }else{
//        // 代码块
//        
//        NSString *current = NSLocalizedString(@"CurrentWifi", nil);
//        NSString *opera = NSLocalizedString(@"Operation_Select", nil);
//        NSString *showTipStr=[NSString stringWithFormat:@"%@%@%@",current,[[KBFetchSystemInfo shareInstance] fetchCurrentWIFIName],opera];
//        UIAlertController *alterVC=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"Wifi_reminder", nil) message:showTipStr preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"Confirm", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self setupWIFI];
//        }];
//        
//        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        
//        [alterVC addAction:confirmAction];
////        [alterVC addAction:cancelAction];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self presentViewController:alterVC animated:YES completion:nil];
//        });
//        
//    }

}


/**
 移除提示框
 */
-(void)dismissAlterVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取当前WIFI信息
//-(void)fetchCurrentWIFIInfo{
//    
//    if ([[[KBFetchSystemInfo shareInstance] fetchCurrentWIFIName] hasPrefix:@"yeehaw3d_"]) {
//        [[KBGCDTimerManager shareInstance] cancelTimerTaskWithName:@"FetchWIFISSID"];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.wifiName.text= [[KBFetchSystemInfo shareInstance]fetchCurrentWIFIName];
//            [self.linkPrinter setTitle:NSLocalizedString(@"Next", nil) forState:0];
//            [self.linkPrinter setTitleColor:[UIColor whiteColor] forState:0];
//            self.linkStatus.image=[UIImage imageNamed:@"LinkWiFiSucIcon"];
//            [self.navigationItem setTitle:NSLocalizedString(@"Connect_printerWi", nil)];
//        });
//    }
//}

//设置网络
-(void)setupWIFI{
    
    NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}


#pragma mark <getter setter>
-(void)setIsResetPrinter:(BOOL)isResetPrinter{
    _isResetPrinter=isResetPrinter;
}
@end
