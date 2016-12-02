//
//  TMXUpdatePrinterName.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXUpdatePrinterName.h"
#import "TMXUpdatePrinterNameModel.h"

@interface TMXUpdatePrinterName ()
{
    TMXUpdatePrinterNameModel *updateModel;     ///<修改打印机名称
    NSMutableDictionary *params;                ///<传入参数
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *saveTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *saveHeight;


@property (strong, nonatomic) IBOutlet KBTextField *inputName;
@property (strong, nonatomic) IBOutlet UILabel *describe;

@property (strong, nonatomic) IBOutlet UIButton *save;

@end

@implementation TMXUpdatePrinterName

- (void)modify
{
    self.inputTop.constant = 64+15*AppScale;
    self.inputHeight.constant = 40*AppScale;
    self.describeTop.constant = 15*AppScale;
    self.describeHeight.constant = 30*AppScale;
    self.saveTop.constant = 50*AppScale;
    self.saveHeight.constant = 40*AppScale;
    self.inputName.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputName.borderStyle = UITextBorderStyleNone;
    self.inputName.backgroundColor = [UIColor whiteColor];
    self.inputName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.describe.font = [UIFont systemFontOfSize:10*AppScale];
    self.save.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.save.layer.cornerRadius = 5*AppScale;
    self.save.layer.masksToBounds = YES;
    self.describe.text = NSLocalizedString(@"PrintName_describe", nil);
    [self.save setTitle:NSLocalizedString(@"Save", nil) forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:NSLocalizedString(@"Name", nil)];
    self.inputName.text = self.name;
    
    updateModel = [[TMXUpdatePrinterNameModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
}

//保存
- (IBAction)saveUpdatePrinterName:(id)sender {
    
    params[@"id"] = @(self.printerID);
    params[@"printerName"] = self.inputName.text;
    if (self.printerType) {
        params[@"printerType"] = @(1);
    }else
    {
        params[@"printerType"] = @(0);
    }
    
    [updateModel FetchTMXUpdatePrinterNameModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"Modify_Suc", nil)];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"Modify_Fail", nil)];
        }
    }];
    
}


#pragma mark  - setter getter
-(void)setName:(NSString *)name
{
    _name = name;
}

-(void)setPrinterID:(NSInteger)printerID
{
    _printerID = printerID;
}

-(void)setPrinterType:(BOOL)printerType
{
    _printerType = printerType;
}

@end
