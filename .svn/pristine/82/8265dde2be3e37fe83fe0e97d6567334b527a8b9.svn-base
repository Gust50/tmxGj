//
//  TMXPersonMyNickNameVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/21.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPersonMyNickNameVC.h"
#import "TMXAccountProfileInfo.h"

@interface TMXPersonMyNickNameVC ()
{
    TMXAccountProfileInfo *profileInfoModel;    ///<修改个人信息数据模型
    NSMutableDictionary *params;    ///<传入参数
}
//输入框
@property (weak, nonatomic) IBOutlet KBTextField *inputNickName;

//确认修改
@property (strong, nonatomic) IBOutlet UIButton *confirmModify;

@end

@implementation TMXPersonMyNickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    self.inputNickName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirmModify.layer.cornerRadius = 5.0;
    self.confirmModify.layer.masksToBounds = YES;
    self.inputNickName.text = self.name;
    [self.confirmModify setTitle:NSLocalizedString(@"Update", nil) forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

//确认修改
- (IBAction)setConfirmModifyEven:(UIButton *)sender {
    if (_tag == 1) {
        //昵称验证
        if ([KBRegexp validateUserName:self.inputNickName.text]) {
            profileInfoModel = [[TMXAccountProfileInfo alloc] init];
            params = [NSMutableDictionary dictionary];
            params[@"nickName"] = self.inputNickName.text;
            [profileInfoModel FetchTMXAccountUpdateProfileInfoData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
                
                if (isSuccess) {
                    [MBProgressHUD showSuccess:NSLocalizedString(@"Modify_Suc", nil)];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateName" object:nil userInfo:nil];
                }else
                {
                    [MBProgressHUD showError:NSLocalizedString(@"Modify_Fail", nil)];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"InputRight_Nick", nil)];
        }
    }else if(_tag == 4)
    {
        //签名验证
        if ([KBRegexp validateUserName:self.inputNickName.text]) {
            profileInfoModel = [[TMXAccountProfileInfo alloc] init];
            params = [NSMutableDictionary dictionary];
            params[@"signature"] = self.inputNickName.text;
            [profileInfoModel FetchTMXAccountUpdateProfileInfoData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
                
                if (isSuccess) {
                    [MBProgressHUD showSuccess:NSLocalizedString(@"Modify_Suc", nil)];
                }else
                {
                    [MBProgressHUD showError:NSLocalizedString(@"Modify_Fail", nil)];
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"InputRight_Sign", nil)];
        }
    }
    
    
}

#pragma mark - setter getter
-(void)setTag:(NSInteger)tag
{
    _tag = tag;
    if (tag == 1) {
        [self.navigationItem setTitle:NSLocalizedString(@"My_NickName", nil)];
    }else if(tag == 4)
    {
        [self.navigationItem setTitle:NSLocalizedString(@"Signature", nil)];
    }
}

-(void)setName:(NSString *)name
{
    _name = name;
}

@end
