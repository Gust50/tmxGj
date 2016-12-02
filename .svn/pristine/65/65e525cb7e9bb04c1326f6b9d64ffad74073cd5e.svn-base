//
//  TMXPrinteringVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinteringVC.h"
#import "TMXPrinteringCell.h"
#import "TMXPrinteringHeadView.h"
#import "TMXPrinterIntoWireVC.h"
#import "TMXPrinterPromptView.h"
#import "TMXPtintingSectionHeadView.h"
#import "TMXAccountPrintTaskModel.h"
#import "TMXAccountPrintTaskModel.h"
#import "TMXAccountPrinterModel.h"
#import "TMXAccountPrinterCommandModel.h"
#import "TMXPrinteringStatusCell.h"
#import "TMXSeeAllCommentVC.h"

@interface TMXPrinteringVC ()<UITableViewDelegate, UITableViewDataSource,TMXPrinteringHeadViewDelegate,TMXPrinteringCellDelegate,TMXPtintingSectionHeadViewDelegate,TMXPrinteringStatusCellDelegate,TMXPrinterPromptViewDelegate>
{
    TMXPrinterPromptView *showCompletionView;      ///<打印完成提示界面
    NSInteger timeSpeed;     ///<更新速度
    BOOL completion;    ///<打印是否完成
    BOOL hasTask;    ///<判断是否有打印任务
    BOOL isAll;
    NSString *currentTemperature;
    NSMutableDictionary *params;    ///<传入打印机参数
    TMXAccountPrintTaskModel *accountPrinterTaskModel;  ///<打印机任务数据模型
    TMXAccountUpdatePrintTaskModel *updatePrintTaskModel;   ///<更新打印机任务数据模型
    TMXAccountPrintTaskDelectFileModel *tMXAccountPrintTaskDelectFileModel;
    TMXAccountPrintModel *tMXAccountPrintModel;
    TMXAccountPrinterCommandModel *cmdModel;      ///<打印机命令模型
    NSMutableDictionary *cmdNeedParams;           ///<打印机指令参数
    BOOL isUpdate;
    NSInteger modelID;
    MBProgressHUD *show_hud;
    
    BOOL isPausedTask;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *goToRemark;      ///<评论进度

@end

@implementation TMXPrinteringVC
static NSString *printeringID = @"TMXPrinteringCell";
static NSString *statusID = @"statusID";
static NSString *headViewID = @"headViewID";

#pragma mark - init
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator=NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:NSLocalizedString(@"Print_Printing", nil)];
    
    [self.view addSubview:self.tableView];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TMXPrinteringCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:printeringID];
    [self.tableView registerClass:[TMXPtintingSectionHeadView class] forHeaderFooterViewReuseIdentifier:headViewID];
//    [self.tableView registerNib:[UINib nibWithNibName:@"TMXPrinteringHeadView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
    
    [self.tableView registerClass:[TMXPrinteringStatusCell class] forCellReuseIdentifier:statusID];

    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //添加打印状态提示框
    showCompletionView = [[[NSBundle mainBundle] loadNibNamed:@"TMXPrinterPromptView" owner:self options:nil] lastObject];
    showCompletionView.frame = [UIScreen mainScreen].bounds;
    showCompletionView.center = self.view.center;
    showCompletionView.delegate=self;
    
    //设置导航栏
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalImage:@"ControllerCenterIcon_white" selectImage:@"ControllerCenterIcon_white" target:self action:@selector(controlCenter)];
//    [self configureLeftBarButtonWithTitle:nil icon:@"Return_white" action:^{
//         [[KBGCDTimerManager shareInstance]cancelAllTimerTask];
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
    
    
    self.goToRemark=NULL;
    [self initData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(234, 97, 1) colorWithAlphaComponent:1]];
    [self enableOpenLeftDrawer:NO];
    show_hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    show_hud.backgroundColor=[UIColor clearColor];
    show_hud.color=[UIColor clearColor];
    show_hud.activityIndicatorColor=systemColor;
    [self loadData];
}


//初始化数据
-(void)initData{
    
    params=[NSMutableDictionary dictionary];
    params[@"printerId"]=_printerId;
    
    accountPrinterTaskModel = [[TMXAccountPrintTaskModel alloc] init];
    tMXAccountPrintTaskDelectFileModel=[[TMXAccountPrintTaskDelectFileModel alloc]init];
    tMXAccountPrintModel=[[TMXAccountPrintModel alloc]init];
    updatePrintTaskModel=[[TMXAccountUpdatePrintTaskModel alloc]init];
    
    cmdModel=[TMXAccountPrinterCommandModel new];
    cmdNeedParams=[NSMutableDictionary dictionary];
    cmdNeedParams[@"printerId"]=_printerId;
}

#pragma mark <loadData>
//更新数据
-(void)updateData{
    
    [updatePrintTaskModel FetchTMXAccountUpdatePrintTaskData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess)
        {
            updatePrintTaskModel=result;
            hasTask = updatePrintTaskModel.hasTask;
            currentTemperature=updatePrintTaskModel.currentTemperature;
            isUpdate=YES;
            isPausedTask=updatePrintTaskModel.isPaused;
            
            if ([updatePrintTaskModel.totalSeconds isEqualToString:updatePrintTaskModel.leftSeconds])
            {
                completion=YES;
            }
            
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//加载数据
- (void)loadData
{
    [accountPrinterTaskModel FetchTMXAccountPrintTaskData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            accountPrinterTaskModel=result;
            currentTemperature=accountPrinterTaskModel.currentTemperature;
            hasTask = accountPrinterTaskModel.hasTask;
            timeSpeed=[accountPrinterTaskModel.refreshFrequency integerValue];
            isUpdate=NO;
            modelID=accountPrinterTaskModel.modelId;
            isPausedTask=accountPrinterTaskModel.isPaused;
            
            if (![[FetchAppPublicKeyModel shareAppPublicKeyManager].isCompletion isEqualToString:@"100"] && [accountPrinterTaskModel.completion isEqualToString:@"100"]) {
                
                [[[UIApplication sharedApplication]keyWindow]addSubview:showCompletionView];
                [FetchAppPublicKeyModel shareAppPublicKeyManager].isCompletion=@"100";
            }else{
                
                [FetchAppPublicKeyModel shareAppPublicKeyManager].isCompletion=accountPrinterTaskModel.completion;
            }
            
            if ([accountPrinterTaskModel.completion isEqualToString:@"100"]) {
                
                isAll=YES;
                
            }else{
                isAll=NO;
                if(hasTask){
                    //开启定时器
                    [[KBGCDTimerManager shareInstance] scheduledDispatchTimerWithName:@"updateTask" timeInterval:timeSpeed queue:nil repeats:YES timerTaskType:removeTimerTaskType action:^{
                        [self updateData];
                    }];
                }
            }
             [show_hud hide:YES];
            [self.tableView reloadData];
        }else{
            show_hud.labelText=NSLocalizedString(@"Load_Fail", nil);
            [show_hud hide:YES afterDelay:2];
        }
    }];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
    [[KBHttpTool shareKBHttpToolManager]cancelAllTask];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[KBGCDTimerManager shareInstance]cancelAllTimerTask];
}


//跳转控制中心
- (void)controlCenter
{
    TMXPrinterIntoWireVC *controlVC = [[TMXPrinterIntoWireVC alloc] init];
    controlVC.printerId=_printerId;
    controlVC.hasTask=hasTask;
    [self.navigationController pushViewController:controlVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else
    {
        return accountPrinterTaskModel.fileList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return CGFLOAT_MIN;
    }else{
    
        return 35*AppScale;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        TMXPtintingSectionHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headViewID];
        if (!headView) {
            headView = [[TMXPtintingSectionHeadView alloc] initWithReuseIdentifier:headViewID];
        }
        headView.delegate = self;
        return headView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
          TMXPrinteringStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:statusID];
        if (!cell) {
            cell = [[TMXPrinteringStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:statusID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.isHasTask=hasTask;
        cell.isPausedTask=isPausedTask;
        
        if (isUpdate) {
            cell.tMXAccountUpdatePrintTaskModel=updatePrintTaskModel;
        }else{
            cell.tMXAccountPrintTaskModel=accountPrinterTaskModel;
        }
        cell.isAll=isAll;
        return cell;
        
    }else{
        TMXPrinteringCell *printerCell = [tableView dequeueReusableCellWithIdentifier:printeringID];
        printerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!printerCell) {
            printerCell = [[TMXPrinteringCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:printeringID];
        }
        printerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        printerCell.listModel=[accountPrinterTaskModel.fileList objectAtIndexCheck:indexPath.row];
//        printerCell.listModel=accountPrinterTaskModel.fileList[indexPath.row];
        printerCell.delegate=self;
        printerCell.isHasTask=hasTask;
        return printerCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 195*AppScale;
    }else
    {
        return 50*AppScale;
    }
}


#pragma mark -- TMXPtintingSectionHeadViewDelegate
- (void)showPrinterHistoryList{

    NSLog(@"打印历史");
}

- (void)refreshUI{

    [[KBGCDTimerManager shareInstance]cancelTimerTaskWithName:@"updateTask"];
    [self loadData];
}


#pragma mark <TMXPrinteringStatusCellDelegate>
-(void)printerPause{
    cmdNeedParams[@"command"]=@(0);
    [self sendCmd];
}

-(void)printerResume{
    cmdNeedParams[@"command"]=@(0);
    [self sendCmd];
}

-(void)printerSwitchWire{
    cmdNeedParams[@"command"]=@(2);
    [self sendCmd];
}

-(void)printerCancel{
    
    [[KBGCDTimerManager shareInstance]cancelTimerTaskWithName:@"updateTask"];
    cmdNeedParams[@"command"]=@(1);
    [self sendCmd];
}

//发送cmd指令
-(void)sendCmd{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=NSLocalizedString(@"Operating", nil);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [cmdModel FetchTMXAccountPrinterCommandData:cmdNeedParams callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [self updateData];
                [hud hide:YES afterDelay:1];
            }else{
                hud.labelText=NSLocalizedString(@"Operat_Fail", nil);
                [hud hide:YES afterDelay:2];
            }
        }];
    });
}

#pragma mark - TMXPrinteringCellDelegate
//删除文件
-(void)deletePrinterFile:(NSString *)fileID{
    
    NSMutableDictionary *printerParams=[NSMutableDictionary dictionary];
    printerParams[@"fileName"]=fileID;
    printerParams[@"printerId"]=_printerId;
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=NSLocalizedString(@"Execute", nil);
    [tMXAccountPrintTaskDelectFileModel FetchTMXAccountPrintDelectFileData:printerParams callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            hud.labelText=NSLocalizedString(@"Work_Suc", nil);
            [hud hide:YES afterDelay:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)1*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loadData];
            });
        }else{
            hud.labelText=NSLocalizedString(@"Work_Fail", nil);
            [hud hide:YES afterDelay:1];
        }
        
    }];
    
}

//打印文件
-(void)printerFile:(NSString *)fileID{
    
    NSMutableDictionary *printerParams=[NSMutableDictionary dictionary];
    printerParams[@"fileName"]=fileID;
    printerParams[@"printerId"]=_printerId ;
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=NSLocalizedString(@"Operating", nil);
    [tMXAccountPrintModel FetchTMXPrintModelFileNameData:printerParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess)
        {
            if (hasTask) {
                
                [[KBGCDTimerManager shareInstance]cancelAllTimerTask];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)1*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loadData];
            });
            hud.labelText=NSLocalizedString(@"Work_Suc", nil);
            [hud hide:YES afterDelay:1];
        }else
        {
            hud.labelText=NSLocalizedString(@"Work_Fail", nil);
            [hud hide:YES afterDelay:1];
        }
    }];
}


-(void)goToRemark{
    TMXSeeAllCommentVC *remarkVC=[TMXSeeAllCommentVC new];
    remarkVC.modelId=modelID;
    [FetchAppPublicKeyModel shareAppPublicKeyManager].isCompletion=@"100";
    [self.navigationController pushViewController:remarkVC animated:YES];
}

#pragma mark <getter setter>
-(void)setPrinterId:(NSString *)printerId{
    
    _printerId=printerId;
}
@end
