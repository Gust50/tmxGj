//
//  TMXCreateQRCodeVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXCreateQRCodeVC.h"
#import "TMXSharePrinterVC.h"
#import "TMXSharePrinterModel.h"

@interface TMXCreateQRCodeVC ()
{
    TMXCreateQRCodeModel *createQRCodeModel;        ///<创建二维码
    NSMutableDictionary *params;
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topDescribeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topDescribeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view1Top;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view1Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shareCountWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shareCountHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomDescribeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view2Top;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *QrcodeTop;


@property (strong, nonatomic) IBOutlet UILabel *topDescribe;
@property (strong, nonatomic) IBOutlet UILabel *bottomDescribe;
@property (strong, nonatomic) IBOutlet UILabel *shareCountLabel;
@property (strong, nonatomic) IBOutlet KBTextField *inputShareCount;
@property (strong, nonatomic) IBOutlet UILabel *personLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet KBTextField *inputTime;
@property (strong, nonatomic) IBOutlet UILabel *minuteLabel;
@property (strong, nonatomic) IBOutlet UIButton *QRCode;



@end

@implementation TMXCreateQRCodeVC

- (void)modify
{
    self.topDescribeTop.constant = 64+20*AppScale;
    self.topDescribeHeight.constant = 15*AppScale;
    self.view1Top.constant = 5*AppScale;
    self.view1Height.constant = 40*AppScale;
    self.shareCountWidth.constant = 100*AppScale;
    self.shareCountHeight.constant = 20*AppScale;
    self.inputWidth.constant = 100*AppScale;
    self.inputHeight.constant = 25*AppScale;
    self.bottomDescribeTop.constant = 20*AppScale;
    self.view2Top.constant = 5*AppScale;
    self.QrcodeTop.constant = 60*AppScale;
    self.topDescribe.font = [UIFont systemFontOfSize:11*AppScale];
    self.topDescribe.textColor = RGBColor(164, 166, 166);
    self.bottomDescribe.font = [UIFont systemFontOfSize:11*AppScale];
    self.bottomDescribe.textColor = RGBColor(164, 166, 166);
    self.shareCountLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputShareCount.font = [UIFont systemFontOfSize:13*AppScale];
    self.personLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.timeLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputTime.font = [UIFont systemFontOfSize:13*AppScale];
    self.minuteLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.QRCode.layer.cornerRadius = 5*AppScale;
    self.QRCode.layer.masksToBounds = YES;
    self.QRCode.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.topDescribe.text = NSLocalizedString(@"TotalNumber", nil);
    self.shareCountLabel.text = NSLocalizedString(@"Number", nil);
    self.personLabel.text = NSLocalizedString(@"Person", nil);
    self.bottomDescribe.text = NSLocalizedString(@"QrCode_time", nil);
    self.timeLabel.text = NSLocalizedString(@"Valid_time", nil);
    self.minuteLabel.text = NSLocalizedString(@"Minute", nil);
    [self.QRCode setTitle:NSLocalizedString(@"Create_QrCode", nil) forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"Sharing_settings", nil)];
    self.view.backgroundColor = backGroundColor;
    createQRCodeModel = [[TMXCreateQRCodeModel alloc] init];
    params = [NSMutableDictionary dictionary];
    [self modify];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

//生成二维码
- (IBAction)createQRcode:(id)sender {
    
    if ([self ValidateIsSuccess]) {
        params[@"printerId"] = @(self.printerId);
        params[@"minutes"] = self.inputTime.text;
        params[@"maxShare"] = self.inputShareCount.text;
        [createQRCodeModel FetchTMXCreateQRCodeModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:result];
                TMXSharePrinterVC *sharePrinterVC = [[TMXSharePrinterVC alloc] init];
                sharePrinterVC.printerId = self.printerId;
                [self.navigationController pushViewController:sharePrinterVC animated:YES];
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
    }
}

//表单验证
- (BOOL)ValidateIsSuccess{
    
    
    if (self.inputShareCount.text.length == 0) {
        [MBProgressHUD showError:NSLocalizedString(@"Input_Person", nil)];
        return NO;
    }else if (![KBRegexp isPureInt:self.inputShareCount.text])
    {
        [MBProgressHUD showError:NSLocalizedString(@"Input_Integet", nil)];
        return NO;
    }else if ([self.inputShareCount.text integerValue] > 20)
    {
        [MBProgressHUD showError:NSLocalizedString(@"Person_Low", nil)];
        return NO;
    }else if (self.inputTime.text.length == 0)
    {
        [MBProgressHUD showError:NSLocalizedString(@"Input_Time", nil)];
        return NO;
    }else if (![KBRegexp isPureInt:self.inputTime.text])
    {
        [MBProgressHUD showError:NSLocalizedString(@"Time_Integet", nil)];
        return NO;
    }else if ([self.inputTime.text integerValue] > 120)
    {
        [MBProgressHUD showError:NSLocalizedString(@"Time_Hight", nil)];
        return NO;
    }else
    {
        return YES;
    }
}

#pragma mark - setter getter
-(void)setPrinterId:(NSInteger)printerId
{
    _printerId = printerId;
}

@end
