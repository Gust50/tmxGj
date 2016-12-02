//
//  TMXProfileEditVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXProfileEditVC.h"
#import "TMXProfileModel.h"

@interface TMXProfileEditVC ()<UIAlertViewDelegate>
{
    NSMutableDictionary *params;                ///<传入参数
    TMXProfileEditOpenStatuModel *openSatusModel;///<模型公开状态
    
    TMXProfileEditDeleteModel *deleteModel;     ///<删除模型
    
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *modelWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *modelHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *modelLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *modelRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *switchWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *switchHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *deleteTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *deleteHeight;


@property (strong, nonatomic) IBOutlet UILabel *modelLabel;
@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UIButton *delete;
@property (strong, nonatomic) IBOutlet UISwitch *modelStatus;


@end

@implementation TMXProfileEditVC

- (void)modify
{
    self.backTop.constant = 64+10*AppScale;
    self.backHeight.constant = 40*AppScale;
    self.modelLeft.constant = 10*AppScale;
    self.modelRight.constant = 10*AppScale;
    self.modelWidth.constant = 150*AppScale;
    self.modelHeight.constant = 20*AppScale;
    self.switchWidth.constant = 49*AppScale;
    self.switchHeight.constant = 31*AppScale;
    self.describeLeft.constant = 15*AppScale;
    self.describeRight.constant = 15*AppScale;
    self.describeHeight.constant = 40*AppScale;
    self.deleteTop.constant = 60*AppScale;
    self.deleteHeight.constant = 40*AppScale;
    self.modelLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.describe.font = [UIFont systemFontOfSize:11*AppScale];
    self.describe.textColor = RGBColor(148, 148, 149);
    self.delete.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.delete.layer.cornerRadius = 5*AppScale;
    self.delete.layer.masksToBounds = YES;
    [NSString labelString:_describe font:[UIFont systemFontOfSize:11*AppScale] range:NSMakeRange(0, 1) color:[UIColor redColor]];
    self.modelLabel.text = NSLocalizedString(@"Model_open", nil);
    self.describe.text = NSLocalizedString(@"Open_describe", nil);
    [self.delete setTitle:NSLocalizedStringFromTable(@"Model_delete", nil, nil) forState:UIControlStateNormal];
    
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
    [self.navigationItem setTitle:NSLocalizedString(@"Edit", nil)];
    self.modelStatus.on = self.isModelOpen;
    
    params = [NSMutableDictionary dictionary];
    deleteModel = [[TMXProfileEditDeleteModel alloc] init];
    openSatusModel = [[TMXProfileEditOpenStatuModel alloc] init];
    params[@"modelId"] = @(self.modelId);
    params[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    
}

//模型公开状态改变
- (IBAction)changeState:(UISwitch *)sender {
    if (sender.on) {
        params[@"isShare"] = @"true";
    }else
    {
        params[@"isShare"] = @"false";
    }
    [openSatusModel FetchTMXProfileEditOpenStatuModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            openSatusModel = result;
            sender.on = openSatusModel.isShare;
            [MBProgressHUD showSuccess:NSLocalizedString(@"Modify_Suc", nil)];
        }else
        {
            sender.on = !sender.on;
            [MBProgressHUD showError:NSLocalizedString(@"Modify_Fail", nil)];
        }
    }];
}

//删除模型
- (IBAction)deleteModel:(UIButton *)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Prompt", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Model_delete", nil), nil];
    [UIView appearance].tintColor = systemColor;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
    }else
    {
        [deleteModel FetchTMXProfileEditDeleteModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"Del_Suc", nil)];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else
            {
                [MBProgressHUD showError:NSLocalizedString(@"Del_Fail", nil)];
            }
        }];
    }
}

#pragma mark - setter getter
-(void)setModelId:(NSInteger)modelId
{
    _modelId = modelId;
}

-(void)setIsModelOpen:(BOOL)isModelOpen
{
    _isModelOpen = isModelOpen;
}

@end
