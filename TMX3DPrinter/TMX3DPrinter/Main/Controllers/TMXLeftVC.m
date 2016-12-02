//
//  TMXLeftVC.m
//  TMX3DPrinterHD
//
//  Created by kobe on 16/8/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXLeftVC.h"
#import "TMXLeftVCCell.h"
#import "TMXLeftHeaderView.h"
#import "AppDelegate.h"
#import "TMXHomeVC.h"
#import "TMXPrinterListViewController.h"
#import "TMXPrinteringVC.h"
#import "TMXCollectVC.h"
#import "TMXLikeVC.h"
#import "TMXProfileVC.h"
#import "TMXSetUpVC.h"
#import "PrinterListViewController.h"
#import "TMXLoginVC.h"
#import "TMXAccountProfileInfo.h"
#import "TMXPersonInformationVC.h"

@interface TMXLeftVC ()<UITableViewDataSource,UITableViewDelegate,TMXLeftHeaderViewDelegate>
{
    TMXAccountProfileInfo *userInfoModel;
    TMXLeftHeaderView *header;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *iconSelectArray;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, assign) NSInteger selectRow;
@end

@implementation TMXLeftVC
static NSString *const cellID=@"cellID";
static NSString *const headerID=@"headerID";

#pragma mark <lazyLoad>
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width*2/3, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.bounces=YES;
    }
    return _tableView;
}

-(NSArray *)iconArray{
    if (!_iconArray) {
        //_iconArray=@[@"Home_normal", @"Printer_normal", @"BuildModel_normal", @"Collect_normal", @"Like_normal", @"Setup_normal", @"Profile_normal"];
        _iconArray=@[@"Home_normal", @"Printer_normal", @"Collect_normal", @"Like_normal", @"Setup_normal", @"Profile_normal"];
    }
    return _iconArray;
}

-(NSArray *)iconSelectArray{
    if (!_iconSelectArray) {
        // _iconSelectArray=@[@"Home_select", @"Printer_Select", @"BuildModel_select", @"Collect_select", @"Like_select", @"Setup_select", @"Profile_select"];
        _iconSelectArray=@[@"Home_select", @"Printer_Select", @"Collect_select", @"Like_select", @"Setup_select", @"Profile_select"];
    }
    return _iconSelectArray;
}

-(NSArray *)nameArray{
    if (!_nameArray) {
        NSString *_home=NSLocalizedString(@"Home",nil);
        NSString *_printer=NSLocalizedString(@"Printer", nil);
        NSString *_collect=NSLocalizedString(@"Collect", nil);
        NSString *_like=NSLocalizedString(@"Like", nil);
        NSString *_setup=NSLocalizedString(@"Setup", nil);
        NSString *_profile=NSLocalizedString(@"Profile", nil);
        _nameArray=@[_home,_printer,_collect,_like,_setup,_profile];
    }
    return _nameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initWithTableView];
    [self initWithiTableHeader];
//    self.selectRow=0;
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_selectRow inSection:0];
//    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self initData];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealLogin:) name:@"LoginSuccess" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNickName:) name:@"updateName" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(switchLanguage:) name:@"SwitchLanguage" object:nil];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notiSelectRow:) name:@"notificationSelectRow" object:nil];
}

-(void)switchLanguage:(NSNotification *)notification{
    
    NSString *_home=NSLocalizedString(@"Home",nil);
    NSString *_printer=NSLocalizedString(@"Printer", nil);
    NSString *_collect=NSLocalizedString(@"Collect", nil);
    NSString *_like=NSLocalizedString(@"Like", nil);
    NSString *_setup=NSLocalizedString(@"Setup", nil);
    NSString *_profile=NSLocalizedString(@"Profile", nil);
    _nameArray=@[_home,_printer,_collect,_like,_setup,_profile];

    [_tableView reloadData];
    [self loadData];
}

-(void)initWithiTableHeader{
    
    header=[[TMXLeftHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 150*AppScale)];
    header.delegate=self;
    header.backGroundImgUrl=@"BackgroundHeader";
    _tableView.tableHeaderView=header;
    
}

- (void)notiSelectRow:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    _selectRow = [dic[@"select"] integerValue];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_selectRow inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    TMXLeftVCCell *cell = (TMXLeftVCCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    cell.selectTextColor = RGBColor(237, 109, 0);
    cell.selectIconUrl=self.iconSelectArray[indexPath.row];
}

-(void)dealLogin:(NSNotification *)notification{
    NSDictionary *dict=notification.userInfo;
    if ([dict[@"isSuccess"] boolValue]) {
        [self loadData];
    }else{
          header.isLogin=NO;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//通知修改昵称
- (void)updateNickName:(NSNotification *)nofi
{
    [self loadData];
}

-(void)initData{
    userInfoModel=[TMXAccountProfileInfo new];
}

-(void)loadData{
    
    [userInfoModel FetchTMXAccountProfileInfoData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            
            userInfoModel=result;
            header.isLogin=YES;
            header.iconUrl=userInfoModel.avatar;
            header.titleNameText=userInfoModel.nickName;
            NSString *_look = NSLocalizedString(@"Look", nil);
            header.subTitleNameText=_look;
           
        }else{
            
            header.isLogin=NO;
        }
     }];
}

-(void)initWithTableView{
    self.view.backgroundColor=backGroundColor;
    self.tableView.backgroundColor=RGBColor(237, 109, 0);
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.tableView];
    _tableView.tableFooterView=[UIView new];
    self.navigationController.navigationBar.tintColor=backGroundColor;
    [_tableView registerClass:[TMXLeftVCCell class] forCellReuseIdentifier:cellID];
}

#pragma mark <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMXLeftVCCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.nameText=[self.nameArray objectAtIndexCheck:indexPath.row];
    cell.iconUrl = [self.iconArray objectAtIndexCheck:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40*AppScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXLeftVCCell *cell = (TMXLeftVCCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    cell.selectTextColor = RGBColor(237, 109, 0);
    cell.selectIconUrl=[self.iconSelectArray objectAtIndexCheck:indexPath.row];
    _selectRow=indexPath.row;
    
//    switch (indexPath.row) {
//        case 0:{
//            KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXHomeVC new]];
//            [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
//        }
//            break;
//        case 1:{
//            
//            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
//                KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXPrinterListViewController new]];
//                [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
//            }else{
//                
//                TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
//                [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
//                
//            }
//           
//        }
//            break;
//        case 2:
//        {
////            KBNavigationVC *nav = [[KBNavigationVC alloc] initWithRootViewController:[KBScanViewController new]];
////            [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
//        }
//            NSLog(@"积木搭建");
//            break;
//        case 3:
//        {
//            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
//                KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXCollectVC new]];
//                [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
//            }else{
//
//                TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
//                [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
//            }
//           
//        }
//            break;
//        case 4:
//        {
//            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
//                KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXLikeVC new]];
//                [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
//            }else{
//
//                TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
//                [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
//            }
//        }
//            break;
//        case 5:
//        {
//            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
//                KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXSetUpVC new]];
//                [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
//            }else{
//
//                TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
//                [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
//            }
//        }
//            break;
//        case 6:
//        {
//            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
//                KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXProfileVC new]];
//                [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
//            }else{
//                
//                TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
//                [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
//            }
//        }
//            break;
//        default:
//            break;
//    }
    
    [self dealIndexSelect:indexPath];
}

-(void)dealIndexSelect:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXHomeVC new]];
            [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
        }
            break;
        case 1:{
            
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXPrinterListViewController new]];
                [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
            }else{
                
                TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
                [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
                
            }
            
        }
            break;
        case 2:
        {
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXCollectVC new]];
                [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
            }else{
                
                TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
                [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
            }

            
            
        }
            NSLog(@"积木搭建");
            break;
        case 3:
        {
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXLikeVC new]];
                [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
            }else{
                
                TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
                [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
            }

        }
            break;
        case 4:
        {
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXSetUpVC new]];
                [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
            }else{
                
                TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
                [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
            }

                    }
            break;
        case 5:
        {
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXProfileVC new]];
                [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
            }else{
                
                TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
                [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
            }
        }
            break;
        default:
            break;
    }

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXLeftVCCell *cell = (TMXLeftVCCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = RGBColor(237, 109, 0);
    
    cell.selectTextColor= [UIColor whiteColor];
    cell.iconUrl=self.iconArray[indexPath.row];
}

#pragma mark <TMXLeftHeaderViewDelegate>
-(void)clickLogin{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_selectRow inSection:0];
    TMXLeftVCCell *cell = (TMXLeftVCCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.selected=NO;
    cell.selectTextColor= [UIColor whiteColor];
    cell.iconUrl=self.iconArray[indexPath.row];
    
    TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
     [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
}

-(void)touchIcon{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_selectRow inSection:0];
    TMXLeftVCCell *cell = (TMXLeftVCCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.selected=NO;
    cell.selectTextColor= [UIColor whiteColor];
    cell.iconUrl=self.iconArray[indexPath.row];
    
     KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:[TMXPersonInformationVC new]];
    [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
}

@end
