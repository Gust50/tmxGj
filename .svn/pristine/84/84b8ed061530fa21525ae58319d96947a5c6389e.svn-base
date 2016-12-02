//
//  TMXPrinterListViewController.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterListViewController.h"
#import "TMXPrinterHeadView.h"
#import "TMXPrinterListTableViewCell.h"
#import "AppDelegate.h"
#import "TMXPopMenuView.h"
#import "TMXCreateQRCodeVC.h"
#import "TMXShareUserListViewController.h"
#import "TMXPrinterTaskListViewController.h"
#import "TMXSelectWorkWiFi.h"
#import "TMXUpdatePrinterName.h"
#import "TMXUnbindViewController.h"
#import "TMXPrinterListModel.h"
#import "TMXControllerCenterSetupVC.h"
#import "TMXSelectWorkWiFi.h"
#import "TMXPrinteringVC.h"
#import "TMXWaitPrintViewController.h"
#import "TMXSharePrinterVC.h"
#import "KBScanViewController.h"
#import "TMXAddPrinterVC.h"
#import "TMXNullView.h"
#import "TMXAdvertiseWebVC.h"

@interface TMXPrinterListViewController ()<UITableViewDelegate,UITableViewDataSource,popMenuCellSelectedDelegate, UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate>
{
    TMXPrinterListModel *printerListModel;                   ///<打印机列表
    NSMutableDictionary *params;                             ///<参数
    
    TMXPrinterUpdateIsDefaultModel *updateIsDefaultModel;     ///<设置默认打印机
    NSMutableDictionary *defaultParams;                       ///<默认打印机参数
    
    TMXUnBindPrinterShareModel *unBindPrinterShareModel;      ///<共享打印机解绑
    NSMutableDictionary *shareParams;                         ///<共享打印机解绑参数

    NSMutableDictionary *infoParams;                          ///<传入参数
    MBProgressHUD *hud;
    
    TMXNullView *nullView;                       ///<无打印机
    
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)TMXPopMenuView * popView;
@end

@implementation TMXPrinterListViewController

static NSString * const TMXPrinterListHeadViewID = @"TMXPrinterListHeadViewID";
static NSString * const TMXPrinterListCellID = @"TMXPrinterListCellID";

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(228, 233, 234);
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    }
    
    return _tableView;
}

- (TMXPopMenuView *)popView{

    if (!_popView) {
        _popView=[[TMXPopMenuView alloc]initWithFrame:CGRectZero];
        _popView.delegate = self;
    }
    return _popView;
}

#pragma mark -- life cycle


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(237, 109, 0) colorWithAlphaComponent:1]];
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor clearColor];
    hud.color=[UIColor clearColor];
    hud.activityIndicatorColor=systemColor;
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self configureLeftBarButtonWithTitle:nil icon:@"MenuIcon" action:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationSelectRow" object:nil userInfo:@{@"select":@"1"}];
        [ShareApp.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];
    
    
    [self configureRightBarButtonWithTitle:nil icon:@"addPrinter_white" action:^{
        [self ClickRightNavBar];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"refresh" object:nil];
}

//重新刷新数据
- (void)refreshData
{
    [self loadData];
}

#pragma mark - loadData
- (void)loadData
{
    params[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    [printerListModel FetchTMXPrinterListModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            printerListModel = result;
            if (!printerListModel.printerList.count && !printerListModel.sharePrinterList.count) {
                [self.view addSubview:nullView];
                WS(weakSelf);
                nullView.block = ^(){
                    //http://www.yeehaw3d.com/order.html
                    TMXAdvertiseWebVC *webVC = [TMXAdvertiseWebVC new];
                    webVC.webUrl = @"https://www.indiegogo.com/projects/the-best-3d-printer-for-creative-kids-only-249#/";
                    [weakSelf.navigationController pushViewController:webVC animated:YES];
                };
            }else
            {
                [nullView removeFromSuperview];
            }
            [hud hide:YES];
            [self.tableView reloadData];
        }else
        {
            hud.labelText=NSLocalizedString(@"Load_Fail", nil);
            [hud hide:YES afterDelay:1];
        }
    }];
}

//设置默认打印机
- (void)loadUpdateIsDefaultData
{
    [updateIsDefaultModel FetchTMXPrinterUpdateIsDefaultModel:defaultParams callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            updateIsDefaultModel = result;
            [MBProgressHUD showSuccess:NSLocalizedString(@"Set_Suc", nil)];
            [self loadData];
            if (updateIsDefaultModel.IsDefault) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"modifyPrinterState" object:nil userInfo:@{@"isSuccess":@"YES"}];
            }else
            {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"modifyPrinterState" object:nil userInfo:@{@"isSuccess":@"NO"}];
            }
        }else
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"modifyPrinterState" object:nil userInfo:@{@"isSuccess":@"Fail"}];
            [MBProgressHUD showError:result];
        }
        
    }];
}

//共享打印机解绑
- (void)loadSharePrinterUnBindData
{
    [unBindPrinterShareModel FetchTMXUnBindPrinterShareModel:shareParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark -- init UI

- (void)initUI{

    NSString *_printerList = NSLocalizedString(@"PrinterList", nil);
    self.navigationItem.title = _printerList;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGBColor(228, 233, 234);
    printerListModel = [[TMXPrinterListModel alloc] init];
    params = [NSMutableDictionary dictionary];
    updateIsDefaultModel = [[TMXPrinterUpdateIsDefaultModel alloc] init];
    defaultParams = [NSMutableDictionary dictionary];
    unBindPrinterShareModel = [[TMXUnBindPrinterShareModel alloc] init];
    shareParams = [NSMutableDictionary dictionary];
    
    infoParams = [NSMutableDictionary dictionary];
    nullView = [[TMXNullView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [self.tableView registerClass:[TMXPrinterHeadView class] forHeaderFooterViewReuseIdentifier:TMXPrinterListHeadViewID];
    [self.tableView registerClass:[TMXPrinterListTableViewCell class] forCellReuseIdentifier:TMXPrinterListCellID];
    [self.view addSubview:_tableView];
    
}

#pragma mark -- 设置导航条右侧nav bar

- (void)ClickRightNavBar{

    NSString *cancelStr = NSLocalizedString(@"Cancel", nil);
    cancelStr.tintColor = systemColor;
    NSString *bindPrinterStr=NSLocalizedString(@"New_printer", nil);
    bindPrinterStr.tintColor=systemColor;
    NSString *qRCodeStr=NSLocalizedString(@"QrCode", nil);
    qRCodeStr.tintColor=systemColor;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:cancelStr destructiveButtonTitle:nil otherButtonTitles:bindPrinterStr, qRCodeStr, nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
    
//    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//       //取消
//    }];
//    
//    UIAlertAction * newPrinterAction = [UIAlertAction actionWithTitle:@"绑定新打印机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    
//    }];
//    
//    UIAlertAction * scanQRcodeAction = [UIAlertAction actionWithTitle:@"二维码扫描" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    
//        //二维码扫描
//    }];
    
//    [cancelAction setValue:systemColor forKey:@"_titleTextColor"];
//    [newPrinterAction setValue:systemColor forKey:@"_titleTextColor"];
//    [scanQRcodeAction setValue:systemColor forKey:@"_titleTextColor"];
//    
//    [alertVC addAction:cancelAction];
//    [alertVC addAction:newPrinterAction];
//    [alertVC addAction:scanQRcodeAction];
    
//    [self presentViewController:alertVC animated:YES completion:nil];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //添加打印机
        TMXSelectWorkWiFi *selectWorkWiFiVC = [[TMXSelectWorkWiFi alloc] init];
        [self.navigationController pushViewController:selectWorkWiFiVC animated:YES];
    }else if (buttonIndex == 1) {
        KBScanViewController *kBScanViewController = [KBScanViewController new];
        [self.navigationController pushViewController:kBScanViewController animated:YES];
    }else if (buttonIndex == 2) {
        
    }
}

#pragma mark-UIImagePickerControllerDelegate
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    //取出选中的图片
//    UIImage *pickerImage=info[UIImagePickerControllerOriginalImage];
//    NSData *dataImage=UIImagePNGRepresentation(pickerImage);
//    
//    //读取图片的二维码数据
//    CIImage *ciImage=[CIImage imageWithData:dataImage];
//    
//    //创建一个探测器
//    CIDetector *dector=[CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyLow}];
//    
//    //利用探测器探测数据
//    NSArray *feture=[dector featuresInImage:ciImage];
//    NSLog(@"----------------->%@",feture);
//    //取出探测器的数据
//    for (CIQRCodeFeature *result in feture) {
//        NSString *url=result.messageString;
//         NSLog(@"----------------->%@",url);
////        [[UIApplication sharedApplication]openURL:[NSURL  URLWithString:url]];
//        //解析数据
//        
//        
//        NSDictionary *dict=[NSDictionary dictionaryWithDictionary:[self parseJSONStringToNSDictionary:[NSObject jsonTypeStringWithString:url]]];
//        NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
//        needParams[@"code"]=dict[@"code"];
//        needParams[@"printerId"]=dict[@"printerId"];
//        TMXAddPrinterVC *addPrnterVC=[TMXAddPrinterVC new];
//        addPrnterVC.requestParams=needParams;
//        [self.navigationController pushViewController:addPrnterVC animated:YES];
//    }
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//
//
//-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
//    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
//    return responseJSON;
//}
#pragma mark -- tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (printerListModel.printerList.count && printerListModel.sharePrinterList.count) {
        return 2;
    }else if (printerListModel.printerList.count && !printerListModel.sharePrinterList.count)
    {
        return 1;
    }else if (!printerListModel.printerList.count && printerListModel.sharePrinterList.count)
    {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (printerListModel.printerList.count && printerListModel.sharePrinterList.count) {
        if (section == 0) {
            
            return printerListModel.printerList.count;
            
        }else
        {
            return printerListModel.sharePrinterList.count;
        }
    }else if (printerListModel.printerList.count && !printerListModel.sharePrinterList.count)
    {
        return printerListModel.printerList.count;
        
    }else if (!printerListModel.printerList.count && printerListModel.sharePrinterList.count)
    {
        return printerListModel.sharePrinterList.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 65*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    TMXPrinterHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:TMXPrinterListHeadViewID];
    if (!headView) {
        headView = [[TMXPrinterHeadView alloc] initWithReuseIdentifier:TMXPrinterListHeadViewID];
    }
    
    if (printerListModel.printerList.count && printerListModel.sharePrinterList.count) {
        if (section == 0) {
            NSString *_binding_printer = NSLocalizedString(@"Binding_printer", nil);
            headView.headLabel.text = _binding_printer;
            
        }else{
            NSString *_share_printer = NSLocalizedString(@"Share_printer", nil);
            headView.headLabel.text = _share_printer;
        }
    }else if (printerListModel.printerList.count && !printerListModel.sharePrinterList.count)
    {
        NSString *_binding_printer = NSLocalizedString(@"Binding_printer", nil);
        headView.headLabel.text = _binding_printer;
        
    }else if (!printerListModel.printerList.count && printerListModel.sharePrinterList.count)
    {
        NSString *_share_printer = NSLocalizedString(@"Share_printer", nil);
        headView.headLabel.text = _share_printer;
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TMXPrinterListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TMXPrinterListCellID];
    if (!cell) {
        cell = [[TMXPrinterListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TMXPrinterListCellID];
    }
    WS(weakSelf);
    
    cell.selectblock = ^(){
        
        if (printerListModel.printerList.count && printerListModel.sharePrinterList.count) {
            
            if (indexPath.section == 0) {
                TMXPrinterListListModel *listModel = printerListModel.printerList[indexPath.row];
                weakSelf.popView.bindModel = listModel;
                weakSelf.popView.isSecondSection = NO;
                infoParams[@"printerId"] = @(listModel.printerListID);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"postPrinterID" object:nil userInfo:infoParams];
                
            }else{
                TMXPrinterListShareListModel *listModel = printerListModel.sharePrinterList[indexPath.row];
                weakSelf.popView.shareListModel = listModel;
                weakSelf.popView.isSecondSection = YES;
            }
            
        }else if (printerListModel.printerList.count && !printerListModel.sharePrinterList.count)
        {
            TMXPrinterListListModel *listModel = printerListModel.printerList[indexPath.row];
            weakSelf.popView.bindModel = listModel;
            weakSelf.popView.isSecondSection = NO;
            infoParams[@"printerId"] = @(listModel.printerListID);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"postPrinterID" object:nil userInfo:infoParams];
            
        }else if (!printerListModel.printerList.count && printerListModel.sharePrinterList.count)
        {
            TMXPrinterListShareListModel *listModel = printerListModel.sharePrinterList[indexPath.row];
            weakSelf.popView.shareListModel = listModel;
            weakSelf.popView.isSecondSection = YES;
        }
         _popView.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT);
        _popView.backgroundColor=[UIColor clearColor];
        [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.7 initialSpringVelocity:10 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
             _popView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
            _popView.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
            [ShareApp.window addSubview:weakSelf.popView];

        } completion:^(BOOL finished) {
           
        }];
    };
    
    if (printerListModel.printerList.count && printerListModel.sharePrinterList.count) {
        
        if (indexPath.section == 0) {
            
            cell.printerListModel = printerListModel.printerList[indexPath.row];
            
        }else{
        
            cell.sharePrinterList = printerListModel.sharePrinterList[indexPath.row];
        }
        
    }else if (printerListModel.printerList.count && !printerListModel.sharePrinterList.count)
    {
        
        cell.printerListModel = printerListModel.printerList[indexPath.row];
        
    }else if (!printerListModel.printerList.count && printerListModel.sharePrinterList.count)
    {
        
        cell.sharePrinterList = printerListModel.sharePrinterList[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXPrinteringVC *printeringVC = [TMXPrinteringVC new];
    TMXWaitPrintViewController *waitPrinterVC = [TMXWaitPrintViewController new];
    TMXPrinterListListModel *listModel = [printerListModel.printerList objectAtIndexCheck:indexPath.row];
    printeringVC.printerId=[NSString stringWithFormat:@"%ld",listModel.printerListID];
    TMXPrinterListShareListModel *shareListModel = [printerListModel.sharePrinterList objectAtIndexCheck:indexPath.row];
    
    if (printerListModel.printerList.count && printerListModel.sharePrinterList.count) {
        
        if (indexPath.section == 0) {
            if ([listModel.status isEqualToString:@"1"]) {
                [MBProgressHUD showError:NSLocalizedString(@"Print_Off", nil)];
            }else
            {
                [self.navigationController pushViewController:printeringVC animated:YES];
            }
        }else{
            waitPrinterVC.printerId = shareListModel.sharePrinterListID;
            [self.navigationController pushViewController:waitPrinterVC animated:YES];
        }
        
    }else if (printerListModel.printerList.count && !printerListModel.sharePrinterList.count)
    {
        
        if ([listModel.status isEqualToString:@"1"]) {
            [MBProgressHUD showError:NSLocalizedString(@"Print_Off", nil)];
        }else
        {
            [self.navigationController pushViewController:printeringVC animated:YES];
        }
        
    }else if (!printerListModel.printerList.count && printerListModel.sharePrinterList.count)
    {
        waitPrinterVC.printerId = shareListModel.sharePrinterListID;
        [self.navigationController pushViewController:waitPrinterVC animated:YES];
    }
}

#pragma mark -- popMenuCellSelectedDelegate

//分享设置
- (void)goShareSettingVC:(NSInteger)printerId isCreateQR:(BOOL)isCreateQR{
    if (isCreateQR) {
        TMXSharePrinterVC * sharePrinterVC = [TMXSharePrinterVC new];
        sharePrinterVC.printerId = printerId;
        [_popView removeFromSuperview];
        [self.navigationController pushViewController:sharePrinterVC animated:YES];
    }else
    {
        TMXCreateQRCodeVC * createQRCodeVC = [TMXCreateQRCodeVC new];
        createQRCodeVC.printerId = printerId;
        [_popView removeFromSuperview];
        [self.navigationController pushViewController:createQRCodeVC animated:YES];
    }
}

//共享用户列表
- (void)goShareUserListVC:(NSInteger)printerId{

    TMXShareUserListViewController * shareUserListVC = [TMXShareUserListViewController new];
    shareUserListVC.printerId = printerId;
    [_popView removeFromSuperview];
    [self.navigationController pushViewController:shareUserListVC animated:YES];
}
//打印机任务列表
- (void)goPrinterTaskListVC:(NSInteger)printerId{

    TMXPrinterTaskListViewController * printerTaskListVC = [TMXPrinterTaskListViewController new];
    printerTaskListVC.printerId = printerId;
    [_popView removeFromSuperview];
    [self.navigationController pushViewController:printerTaskListVC animated:YES];
}
//备注名称
-(void)goUpdatePrinterName:(NSInteger)printerId name:(NSString *)name printerType:(BOOL)printerType
{
    TMXUpdatePrinterName *updateNameVC = [[TMXUpdatePrinterName alloc] init];
    updateNameVC.printerID = printerId;
    updateNameVC.name = name;
    updateNameVC.printerType = printerType;
    [_popView removeFromSuperview];
    [self.navigationController pushViewController:updateNameVC animated:YES];
}

//重新设置打印机wifi
- (void)goResetPrinterWifiVC:(NSInteger)printerId status:(NSString *)status
{
    [_popView removeFromSuperview];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm_reset", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Confirm", nil), nil];
    [UIView appearance].tintColor = systemColor;
    [alert show];
//    if (![status isEqualToString:@"离线"]) {
//        
//    }else
//    {
//        [MBProgressHUD showError:@"该打印机处于离线状态"];
//    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:NSLocalizedString(@"Confirm_reset", nil)]) {
        if (buttonIndex == 1) {
            TMXSelectWorkWiFi *selectWorkWifi = [[TMXSelectWorkWiFi alloc] init];
            selectWorkWifi.isResetPrinter=YES;
            [self.navigationController pushViewController:selectWorkWifi animated:YES];
        }
    }else
    {
        if (buttonIndex == 1) {
            shareParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
            [self loadSharePrinterUnBindData];
        }
    }
}

//解除打印机
-(void)unBindPrinter:(NSInteger)printerId isSecondView:(BOOL)isSecondView
{
    if (isSecondView) {
        //共享打印机解绑
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm_remove", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Confirm", nil), nil];
        [UIView appearance].tintColor = systemColor;
        shareParams[@"printerShareId"] = @(printerId);
        [_popView removeFromSuperview];
        [alert show];
        
    }else
    {
        TMXUnbindViewController *unBindVC = [[TMXUnbindViewController alloc] init];
        unBindVC.printerID = printerId;
        [_popView removeFromSuperview];
        [self.navigationController pushViewController:unBindVC animated:YES];
    }
}

//设置默认打印机
-(void)clickSelectDefault:(NSInteger)printerId printerType:(BOOL)printerType isDefault:(BOOL)isDefault
{
    defaultParams[@"id"] = @(printerId);
    if (printerType) {
        defaultParams[@"printerType"] = @(1);
    }else
    {
        defaultParams[@"printerType"] = @(0);
    }
    if (isDefault) {
        defaultParams[@"isDefault"] = @"true";
    }else
    {
        defaultParams[@"isDefault"] = @"false";
    }
    [self loadUpdateIsDefaultData];
}

//高级设置
- (void)goAdvancedSetting:(NSInteger)printerId status:(NSString *)status
{
    if (![status isEqualToString:@"1"]) {
        TMXControllerCenterSetupVC *setupVC = [[TMXControllerCenterSetupVC alloc]init];
        setupVC.printerId = printerId;
        [_popView removeFromSuperview];
        [self.navigationController pushViewController:setupVC animated:YES];
    }else
    {
        [MBProgressHUD showError:NSLocalizedString(@"Print_Off", nil)];
    }
    
}

@end
