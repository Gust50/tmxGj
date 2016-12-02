//
//  TMXWi-FiConnectionStatus.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/7/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXWiFiConnectionStatusVC.h"
#import "TMXAddPrinterModel.h"
#import <AFNetworking.h>

@interface TMXWiFiConnectionStatusVC ()
{
    TMXAddPrinterModel *addPrinterModel;
    TMXAddPrinterStatusModel *printerStatusModel;
    MBProgressHUD *hud;
}
/** 连接网络状态 */
@property (strong, nonatomic) IBOutlet UIImageView *connectionNetStatus;
/** 绑定用户状态 */
@property (strong, nonatomic) IBOutlet UIImageView *bindUserStatus;
/** 完成状态 */
@property (strong, nonatomic) IBOutlet UIImageView *finishStatus;
@property (strong, nonatomic) IBOutlet UIButton *startExperience;
//绑定用户
@property (strong, nonatomic) IBOutlet UILabel *bind;
@property (strong, nonatomic) IBOutlet UILabel *linkNet;

//完成
@property (strong, nonatomic) IBOutlet UILabel *finish;


@end

@implementation TMXWiFiConnectionStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    addPrinterModel=[[TMXAddPrinterModel alloc]init];
    printerStatusModel=[[TMXAddPrinterStatusModel alloc]init];
    
    [self.navigationItem setTitle:NSLocalizedString(@"Connection_status", nil)];
    self.view.backgroundColor = backGroundColor;
    self.startExperience.layer.cornerRadius = 5.0;
    self.startExperience.layer.masksToBounds = YES;
    self.connectionNetStatus.userInteractionEnabled = YES;
    self.bindUserStatus.userInteractionEnabled = YES;
    self.finishStatus.userInteractionEnabled = YES;
    UITapGestureRecognizer *connectionNetGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isLinkNetWork)];
    UITapGestureRecognizer *bindUserGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isBindUser)];
    UITapGestureRecognizer *finishGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isfinish)];
    [self.connectionNetStatus addGestureRecognizer:connectionNetGesture];
    [self.bindUserStatus addGestureRecognizer:bindUserGesture];
    [self.finishStatus addGestureRecognizer:finishGesture];
    self.bind.text = NSLocalizedString(@"Binding_user", nil);
    self.linkNet.text = NSLocalizedString(@"Connect_network", nil);
    self.finish.text = NSLocalizedString(@"Complete", nil);
    [self.startExperience setTitle:NSLocalizedString(@"Experience", nil) forState:0];
    
    if (_isResetPrinter) {
        self.bindUserStatus.image=[UIImage imageNamed:@"LinkWiFiSucIcon"];
        self.bind.text=NSLocalizedString(@"Complete", nil);
        self.finishStatus.hidden=YES;
        self.finish.hidden=YES;
        [self.startExperience setTitle:NSLocalizedString(@"Experience", nil) forState:0];
        
    }else{
        //        [[MBProgressHUD showMessage:@"正在加载中..."]hide:YES afterDelay:5.0];
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)3.0*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.backgroundColor=[UIColor clearColor];
        hud.color=[UIColor clearColor];
        hud.activityIndicatorColor=systemColor;
        [self checkPrinterStatus];
        //        });
    }
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}


//检查打印机的状态
-(void)checkPrinterStatus{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"printerId"]=_printerId;
    
    [printerStatusModel FetchTMXPrinterStatusData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            
            printerStatusModel=result;
            [hud hide:YES];
            if([printerStatusModel.printerStatus isEqualToString:@"2"]){
//                self.bindUserStatus.image=[UIImage imageNamed:@"LinkWiFiSucIcon"];
                self.finishStatus.image=[UIImage imageNamed:@"LinkWiFiSucIcon"];
            }else{
//                self.bindUserStatus.image=[UIImage imageNamed:@"LinkWiFiFailIcon"];
                self.finishStatus.image=[UIImage imageNamed:@"LinkWiFiFailIcon"];
            }
            
        }else{
            //             hud.labelText=@"数据加载失败";
            [MBProgressHUD showError:result];
        }
    }];
}


//设置网络
-(void)setupNetworking{
    
    NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}


//连接网络状态
- (void)isLinkNetWork
{
    NSLog(@"isLinkNetWork");
}
//绑定用户状态
- (void)isBindUser
{
    NSLog(@"isBindUser");
}
//完成状态
- (void)isfinish
{
    NSLog(@"isfinish");
}

//开始体验
- (IBAction)readyExperience:(UIButton *)sender {
    
    
    if ([printerStatusModel.printerStatus isEqualToString:@"2"]) {
        
        [self.startExperience setTitle:NSLocalizedString(@"Experience", nil) forState:0];
    }else{
        [self.startExperience setTitle:NSLocalizedString(@"Readd", nil) forState:0];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}



//检查网络是否可以使用

-(void)isConnectionAvailable{
    
    
    AFNetworkReachabilityManager *manager=[AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //                [MBProgressHUD showError:@"未知"];
                [self setupNetworking];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //                [MBProgressHUD showError:@"没有网络"];
                [self setupNetworking];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self checkPrinterStatus];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [self checkPrinterStatus];
                //                [MBProgressHUD showSuccess:@"WIFI"];
                break;
            default:
                break;
        }
    }];
}



#pragma  mark <getter setter>
-(void)setPrinterId:(NSString *)printerId{
    _printerId=printerId;
}

-(void)setIsResetPrinter:(BOOL)isResetPrinter{
    _isResetPrinter=isResetPrinter;
}

@end
