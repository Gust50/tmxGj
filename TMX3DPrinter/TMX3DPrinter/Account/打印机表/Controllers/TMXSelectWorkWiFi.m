//
//  TMXSelectWorkWiFi.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/7/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXSelectWorkWiFi.h"
#import "TMXNoLinkWifiVC.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "TMXSelectWifiView.h"
#import "KBDropMenuView.h"

@interface TMXSelectWorkWiFi ()<TMXSelectWifiViewDelegate>

{
    NSUserDefaults *userDefaults;    ///<存储
    BOOL isSeePassword;              ///<是否显示密码
    KBDropMenuView *dropMenuView;
    TMXSelectWifiView *tMXSelectWifiView;
}
//背景图
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet KBTextField *inputAccount;
@property (strong, nonatomic) IBOutlet KBTextField *inputPassword;
@property (strong, nonatomic) IBOutlet UIButton *confirm;
@property (weak, nonatomic) IBOutlet UIButton *remember;
- (IBAction)rememberBtn:(id)sender;
- (IBAction)arrowBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *arrow;
@property (nonatomic,assign) BOOL isRememberPassword;
@property (nonatomic, strong) UIButton *backGroundBtn;
@property (nonatomic, assign) BOOL isClick;
@end

@implementation TMXSelectWorkWiFi

#pragma mark <lazyLoad>
-(UIButton *)backGroundBtn{
    
    if (!_backGroundBtn) {
        _backGroundBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _backGroundBtn.backgroundColor=[UIColor clearColor];
        [_backGroundBtn addTarget:self action:@selector(removeBackgroundBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backGroundBtn;
}


#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    userDefaults=[NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:NSLocalizedString(@"Choose_wi-fi", nil)];
    
    self.isRememberPassword=NO;
    self.isClick=NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
    self.inputAccount.text=[userDefaults objectForKey:@"Account"];
    
    if ([userDefaults boolForKey:@"rememberPassword"]) {
        self.inputPassword.text=[userDefaults objectForKey:@"Password"];
        self.remember.selected=YES;
    }else{
        self.inputPassword.text=nil;
        self.remember.selected=NO;
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

#pragma mark <private method>
- (void)modify
{
    
    [self.remember setImage:[UIImage imageNamed:@"NoSelectIcon"] forState:0];
    [self.remember setImage:[UIImage imageNamed:@"SelectIcon"] forState:UIControlStateSelected];
    [self.remember setTitle:NSLocalizedString(@"Remember_password", nil) forState:UIControlStateNormal];
    [self.arrow setImage:[UIImage imageNamed:@"BottomArrowIcon"] forState:0];
    self.remember.selected=NO;
    
    self.backView.layer.borderWidth = 1.0;
    self.backView.layer.borderColor = RGBColor(208, 208, 208).CGColor;
    self.backView.layer.cornerRadius = 8.0;
    self.backView.layer.masksToBounds = YES;
    self.confirm.layer.cornerRadius = 5.0;
    self.confirm.layer.masksToBounds = YES;
    self.inputAccount.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputAccount.borderStyle = UITextBorderStyleNone;
    self.inputPassword.borderStyle = UITextBorderStyleNone;
    self.inputPassword.secureTextEntry=YES;
    isSeePassword=NO;
    self.inputAccount.placeholder = NSLocalizedString(@"Connect", nil);
    self.inputPassword.placeholder = NSLocalizedString(@"input_wifi", nil);
    [self.confirm setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
}

//添加wifi
-(void)addWifi{
    //add array
    NSMutableDictionary *tempDict=[NSMutableDictionary dictionaryWithDictionary:[userDefaults objectForKey:@"saveWifi"]];
    NSArray *tempName=[tempDict allKeys];
    BOOL isExist=NO;
    for (NSString *str in tempName) {
        
        if ([str isEqualToString:self.inputAccount.text]) {
            isExist=YES;
            break;
        }else{
            isExist=NO;
            continue;
        }
    }
    
    if (!isExist) {
        
        tempDict[self.inputAccount.text]=self.inputPassword.text;
        [userDefaults setObject:tempDict forKey:@"saveWifi"];
        [userDefaults synchronize];
    }
    
}

//表单验证
-(BOOL)isSuccess{
    if (self.inputAccount.text.length==0) {
        [MBProgressHUD showError:NSLocalizedString(@"InputWifi_acount", nil)];
        return NO;
    }else{
        if ([KBRegexp isContainerChineseString:self.inputAccount.text] || [KBRegexp isBlankString:self.inputAccount.text]) {
            [MBProgressHUD showError:NSLocalizedString(@"NoNull", nil)];
            return NO;
        }
        return YES;
    }
}


#pragma mark <otherResponse>
//密码是否可见
- (IBAction)isSeePassword:(UIButton *)sender {
    if (isSeePassword) {
        self.inputPassword.secureTextEntry=YES;
        [sender setImage:[UIImage imageNamed:@"NoDisplayPassword"] forState:UIControlStateNormal];
        isSeePassword=NO;
    }else{
        self.inputPassword.secureTextEntry=NO;
        [sender setImage:[UIImage imageNamed:@"DisplayPassword"] forState:UIControlStateNormal];
        isSeePassword=YES;
    }
}

- (IBAction)rememberBtn:(id)sender {
    
    if (self.remember.isSelected) {
        
        self.remember.selected=NO;
        _isRememberPassword=NO;
        [userDefaults setBool:NO forKey:@"rememberPassword"];
    }else{
        
        _isRememberPassword=YES;
        self.remember.selected=YES;
         [userDefaults setBool:YES forKey:@"rememberPassword"];
    }
}

- (IBAction)arrowBtn:(id)sender {
    
    [self.view endEditing:YES];
    if (_isClick) {
        
        _isClick=NO;
        [dropMenuView hideMenu];
        [_backGroundBtn removeFromSuperview];
       
        
        [UIView animateWithDuration:0.25 animations:^{
             self.arrow.transform=CGAffineTransformIdentity;
        }];
        
    }else{
        
        if (dropMenuView.menuState==MenuShow) return;
        tMXSelectWifiView=[TMXSelectWifiView new];
        tMXSelectWifiView.delegate=self;
        
        [UIView animateWithDuration:0.25 animations:^{
             self.arrow.transform=CGAffineTransformMakeRotation(M_PI);
        }];
        
        dropMenuView = [[KBDropMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH-30, SCREENHEIGHT/2.5)];
        dropMenuView.contentView= tMXSelectWifiView;
        dropMenuView.anchorPoint = CGPointMake(0.5, 0);
        dropMenuView.origin = CGPointMake(0, 4);
        dropMenuView.backGroundImg = @"BackCartBack";
        [dropMenuView shoViewFromPoint:CGPointMake(15,64+200*AppScale)];
        _isClick=YES;
        [self.view addSubview:self.backGroundBtn];
         [self.view addSubview:dropMenuView];
    }
}


//确认
- (IBAction)confirmWiFi:(UIButton *)sender {
    
    if ([self isSuccess]) {
        
        [userDefaults setObject:self.inputAccount.text forKey:@"Account"];
        if ([userDefaults objectForKey:@"rememberPassword"]) {
            
            [userDefaults setObject:self.inputPassword.text forKey:@"Password"];
        }
        [userDefaults synchronize];
        
        
        [self addWifi];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.8*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            TMXNoLinkWifiVC *linkWifiVC = [[TMXNoLinkWifiVC alloc] init];
            linkWifiVC.isResetPrinter=_isResetPrinter;
            [self.navigationController pushViewController:linkWifiVC animated:YES];
        });
        
    }
}


-(void)removeBackgroundBtn:(UIButton *)btn{
    [_backGroundBtn removeFromSuperview];
    [dropMenuView hideMenu];
     _isClick=NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.arrow.transform=CGAffineTransformIdentity;
    }];
}

#pragma mark <TMXSelectWifiViewDelegate>
-(void)selectWifiName:(NSString *)name password:(NSString *)password{
    
    [self removeBackgroundBtn:nil];
    self.inputAccount.text=name;
    self.inputPassword.text=password;
}


#pragma mark <getter setter>
-(void)setIsResetPrinter:(BOOL)isResetPrinter{
    _isResetPrinter=isResetPrinter;
}
@end
