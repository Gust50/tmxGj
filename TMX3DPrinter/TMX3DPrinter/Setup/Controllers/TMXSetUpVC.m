//
//  TMXSetUpVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/8.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXSetUpVC.h"
#import "TMXInformationFeedbackVC.h"
#import "TMXLoginVC.h"
#import "TMXAboutYeehawVC.h"
#import "TMXAccountModel.h"
#import "AppDelegate.h"
#import "TMXSelectLanguage.h"

#define Clear NSLocalizedString(@"Clean", nil)

@interface TMXSetUpVC ()<UIAlertViewDelegate>

{
    TMXAccountLoginModel *tMXAccountLoginModel;
}
@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *language;

- (IBAction)clearDisk:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *exit;
@property (strong, nonatomic) IBOutlet UILabel *yeehawLabel;
@property (strong, nonatomic) IBOutlet UILabel *info;
@property (strong, nonatomic) IBOutlet UILabel *clearLabel;
@property (strong, nonatomic) IBOutlet UILabel *changeLanguage;

@property (nonatomic, strong)TMXSelectLanguage *selectLanguageView;

@end

@implementation TMXSetUpVC

-(TMXSelectLanguage *)selectLanguageView
{
    if (!_selectLanguageView) {
        _selectLanguageView = [[TMXSelectLanguage alloc] initWithFrame:CGRectZero];
    }
    return _selectLanguageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"Setup", nil)];
    self.view.backgroundColor = backGroundColor;
    self.cacheSizeLabel.font = [UIFont systemFontOfSize:10*AppScale];
    self.language.font = [UIFont systemFontOfSize:10*AppScale];
    self.cacheSizeLabel.textColor = RGBColor(30, 30, 30);
    tMXAccountLoginModel=[[TMXAccountLoginModel alloc]init];
    [self.exit setTitle:NSLocalizedString(@"Exit_login", nil) forState:UIControlStateNormal];
    self.yeehawLabel.text = NSLocalizedString(@"Yeehaw", nil);
    self.info.text = NSLocalizedString(@"Info_feedback", nil);
    self.clearLabel.text = NSLocalizedString(@"Clean", nil);
    self.changeLanguage.text = NSLocalizedString(@"Change_language", nil);
    self.language.text = NSLocalizedString(@"CurrentLanguage", nil);
    float tmpSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
    NSString *clearCacheSizeStr = tmpSize >= 1 ? [NSString stringWithFormat:@"%@(%.2fM)",Clear,tmpSize] : [NSString stringWithFormat:@"%@(%.2fK)",Clear,tmpSize * 1024];
    self.cacheSizeLabel.text=clearCacheSizeStr;
    
    [self configureLeftBarButtonWithTitle:nil icon:@"MenuIcon" action:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationSelectRow" object:nil userInfo:@{@"select":@"5"}];
        [ShareApp.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUI:) name:@"UpdateUI" object:nil];
    
//   NSString *code=[[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"][0];
//    if ([code isEqualToString:@"en"]) {
//        self.language.text = NSLocalizedString(@"en-US", nil);
//    }else if ([code isEqualToString:@"zh-Hans"])
//    {
//        self.language.text = NSLocalizedString(@"en-CH", nil);
//    }
    

}

-(void)updateUI:(NSNotification *)notification{
    [self.navigationItem setTitle:NSLocalizedString(@"Setup", nil)];
    self.view.backgroundColor = backGroundColor;
    self.cacheSizeLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.cacheSizeLabel.textColor = RGBColor(30, 30, 30);
    tMXAccountLoginModel=[[TMXAccountLoginModel alloc]init];
    [self.exit setTitle:NSLocalizedString(@"Exit_login", nil) forState:UIControlStateNormal];
    self.yeehawLabel.text = NSLocalizedString(@"Yeehaw", nil);
    self.info.text = NSLocalizedString(@"Info_feedback", nil);
    self.clearLabel.text = NSLocalizedString(@"Clean", nil);
    self.changeLanguage.text = NSLocalizedString(@"Change_language", nil);
    self.language.text = NSLocalizedString(@"CurrentLanguage", nil);
    float tmpSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
    NSString *clearCacheSizeStr = tmpSize >= 1 ? [NSString stringWithFormat:@"%@(%.2fM)",Clear,tmpSize] : [NSString stringWithFormat:@"%@(%.2fK)",Clear,tmpSize * 1024];
    self.cacheSizeLabel.text=clearCacheSizeStr;
    
//    NSString *code=[[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"][0];
//    if ([code isEqualToString:@"en"]) {
//        self.language.text = NSLocalizedString(@"en-US", nil);
//    }else if ([code isEqualToString:@"zh-Hans"])
//    {
//        self.language.text = NSLocalizedString(@"en-CH", nil);
//    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(234, 97, 1) colorWithAlphaComponent:1]];
}

//退出登录
- (IBAction)setExitLogin:(UIButton *)sender {
    
    
    [tMXAccountLoginModel FetchTMXAccountLogoutData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
       
        if (isSuccess) {
            
            [MBProgressHUD showSuccess:NSLocalizedString(@"Log_out", nil)];
            dispatch_after((dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC))), dispatch_get_main_queue(), ^{
//                TMXLoginVC *loginVC = [[TMXLoginVC alloc] init];
               
                
//                [self.parentViewController presentViewController:loginVC animated:YES completion:nil];
                TMXLoginVC *loginVC=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
                 loginVC.isBackToRootTabbar=YES;
                [ShareApp.drawerController setCenterViewController:loginVC withCloseAnimation:YES completion:nil];
            });
        }else{
            
             [MBProgressHUD showError:result];
        }
    }];
}
//关于Yeehaw
- (IBAction)setAboutYeehaw:(UIButton *)sender {
    if (sender.tag == 1) {
        TMXAboutYeehawVC *yeehawVC = [[TMXAboutYeehawVC alloc] init];
        [self.navigationController pushViewController:yeehawVC animated:YES];
    }
    
}
//信息反馈
- (IBAction)setInformation:(UIButton *)sender {
    if (sender.tag == 2) {
        TMXInformationFeedbackVC *infoFeedback = [[TMXInformationFeedbackVC alloc] init];
        [self.navigationController pushViewController:infoFeedback animated:YES];

    }
}
//清除缓存
- (IBAction)clearDisk:(id)sender {
    
    float tmpSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
    NSString *clearCacheSizeStr = tmpSize >= 1 ? [NSString stringWithFormat:@"%@(%.2fM)",Clear,tmpSize] : [NSString stringWithFormat:@"%@(%.2fK)",Clear,tmpSize * 1024];

    UIAlertView *showCache=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Size", nil) message:clearCacheSizeStr delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Cleanup", nil), nil];
    [UIView appearance].tintColor = systemColor;
    [showCache show];
    
    [[SDImageCache sharedImageCache] clearDisk];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0)
    {
        
    }else
    {
        [[SDImageCache sharedImageCache] clearDisk];
        float tmpSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
        NSString *clearCacheSizeStr = tmpSize >= 1 ? [NSString stringWithFormat:@"%@(%.2fM)",Clear,tmpSize] : [NSString stringWithFormat:@"%@(%.2fK)",Clear,tmpSize * 1024];
        
        self.cacheSizeLabel.text=clearCacheSizeStr;
    }
}

//切换语言
- (IBAction)changeLanguage:(UIButton *)sender {
    
    WS(weakSelf);
    self.selectLanguageView.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT);
    self.selectLanguageView.backgroundColor=[UIColor clearColor];
    self.selectLanguageView.isUpdate=YES;
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.7 initialSpringVelocity:10 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        _selectLanguageView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
        _selectLanguageView.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        [ShareApp.window addSubview:weakSelf.selectLanguageView];
        
    } completion:^(BOOL finished) {
        
    }];
}


@end
