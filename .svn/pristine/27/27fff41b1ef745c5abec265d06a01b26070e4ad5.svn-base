//
//  TMXPrinterTaskListViewController.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterTaskListViewController.h"
#import "TMXPrinterTaskCell.h"
#import "TMXPrinterTaskListModel.h"
#import "KBSegmentView.h"
#include "TMXPrinterTaskFooterView.h"
#import "TMXPrinteringVC.h"
#import "TMXPrinterTaskBar.h"
#import "TMXPrinterTaskStatusView.h"
#import "TMXQueueArchiveFooterView.h"
#import "KBDragTableView.h"
#import "TMXWaitPrinterModel.h"

@interface TMXPrinterTaskListViewController ()<UITableViewDelegate,UITableViewDataSource, KBSegmentViewDelegate, TMXPrinterTaskBarDelegate, TMXPrinterTaskStatusViewDelegate, UIAlertViewDelegate,KBDragTableViewDelegate,KBDragTableViewDataSource>
{
    TMXPrinterTaskListModel *printerTaskListModel;      ///<打印任务列表
    NSMutableDictionary *params;                        ///<传入参数
    NSInteger pageNum;                                  ///<当前页码
    
    TMXCancelPrinterTaskModel *cancelTaskModel;         ///<取消打印任务（正在打印中的任务）
    NSMutableDictionary *cancelParams;                  ///<取消打印任务参数
    
    TMXStartPrinterTaskModel *startTaskModel;           ///<开始打印任务
    NSMutableDictionary *startParams;                   ///<开始打印任务参数
    
    TMXStopPrinterTaskModel *stopTaskModel;             ///<停止打印任务
    NSMutableDictionary *stopParams;                   ///<停止打印任务参数
    
    TMXPrintQueueArchiveModel *printQueueArchiveModel;  ///<打印任务存档
    NSMutableDictionary *archiveParams;                 ///<打印任务存档参数
    
    TMXRestoreQueueArchiveModel *restoreArchiveModel;   ///<存档任务批量复原
    NSMutableDictionary *restoreParams;                 ///<存档任务批量复原参数
    
    TMXUpdatePrinterOrderModel *updatePrinterOrderModel;///<打印任务重新排序
    NSMutableDictionary *updateOrderParams;
    
    TMXWaitPrinterCancelModel *cancelModel; ///<删除打印任务
    NSMutableDictionary *canParams;          ///<传入任务ID
    
    NSArray *topArray;
    KBSegmentView * segmentView;
    TMXPrinterTaskBar *printerTaskBar;                  ///<恢复存档任务
    TMXPrinterTaskStatusView *updataTaskStatusView;     ///<修改任务状态视图
    NSInteger selectTag;                                ///<选中打印任务还是存档任务或者恢复存档
    NSInteger segmentTag;                               ///<选中任务状态
    
    BOOL selectCell;                                   ///<是否选择存档任务
    BOOL isLoadFooterView;                             ///<是否加载尾部视图
    
    UISegmentedControl *segmentControl;
}

@property (nonatomic,strong)KBDragTableView * tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableArray *taskIDArray;       ///<选择存档任务id数组

@end

@implementation TMXPrinterTaskListViewController

static NSString * const PrinterTaskListCellID = @"PrinterTaskListCellID";

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView=[[KBDragTableView alloc]init];
        _tableView.frame=CGRectMake(0, 64+50*AppScale, SCREENWIDTH, SCREENHEIGHT-64-50*AppScale);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableArray *)taskIDArray
{
    if (!_taskIDArray) {
        _taskIDArray = [NSMutableArray array];
    }
    return _taskIDArray;
}

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self loadNav];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

#pragma mark - nav
- (void)loadNav
{
    NSString *_printTask = NSLocalizedString(@"PrintTask", nil);
    NSString *_archiveTask = NSLocalizedString(@"ArchiveTask", nil);
    NSArray *segArray = @[_printTask, _archiveTask];
    segmentControl = [[UISegmentedControl alloc] initWithItems:segArray];
    segmentControl.tintColor = [UIColor whiteColor];
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:systemColor} forState:UIControlStateSelected];
    [segmentControl addTarget:self action:@selector(taskStatus:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentControl;
    
}

#pragma mark -- initUI
- (void)initUI{

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerClass:[TMXPrinterTaskCell class] forCellReuseIdentifier:PrinterTaskListCellID];
    [self.view addSubview:self.tableView];
    NSString *wait = NSLocalizedString(@"WaitPrint", nil);
    NSString *printing = NSLocalizedString(@"Printing", nil);
    NSString *printed = NSLocalizedString(@"Printed", nil);
    NSString *have_cancel = NSLocalizedString(@"Have_cancel", nil);
    
    topArray = @[wait,printing,printed,have_cancel];
    segmentView = [KBSegmentView createSegmentFrame:CGRectMake(0, 65, SCREENHEIGHT, 40*AppScale) segmentTitleArr:topArray backgroundColor:[UIColor whiteColor] titleColor:RGBColor(45, 45, 45) selectTitleColor:systemColor titleFont:[UIFont systemFontOfSize:12*AppScale] bottomLineColor:systemColor isVerticleBar:NO delegate:self];
    [self.view addSubview:segmentView];
    
     printerTaskBar = [[TMXPrinterTaskBar alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-40*AppScale, SCREENWIDTH, 40*AppScale)];
    printerTaskBar.delegate = self;
    
    printerTaskListModel = [TMXPrinterTaskListModel new];
    params = [NSMutableDictionary dictionary];
    startTaskModel = [[TMXStartPrinterTaskModel alloc] init];
    startParams = [NSMutableDictionary dictionary];
    printQueueArchiveModel = [[TMXPrintQueueArchiveModel alloc] init];
    archiveParams = [NSMutableDictionary dictionary];
    stopTaskModel = [[TMXStopPrinterTaskModel alloc] init];
    stopParams = [NSMutableDictionary dictionary];
    cancelTaskModel = [[TMXCancelPrinterTaskModel alloc] init];
    cancelParams = [NSMutableDictionary dictionary];
    restoreArchiveModel = [[TMXRestoreQueueArchiveModel alloc] init];
    restoreParams = [NSMutableDictionary dictionary];
    updatePrinterOrderModel = [TMXUpdatePrinterOrderModel new];
    updateOrderParams = [NSMutableDictionary dictionary];
    
    cancelModel = [[TMXWaitPrinterCancelModel alloc] init];
    canParams = [NSMutableDictionary dictionary];
    
    params[@"status"] = @(0);
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - loadData
- (void)loadNewData
{
    pageNum = 1;
    params[@"pageNumber"] = @(pageNum);
    params[@"pageSize"] = @(10);
    params[@"printerId"] = @(self.printerId);
    [printerTaskListModel FetchTMXPrinterTaskListModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            printerTaskListModel = result;
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:printerTaskListModel.printQueueList];
            [self.tableView reloadData];
            [self loadFooter];
            [self.tableView.mj_header endRefreshing];
            if (printerTaskListModel.printQueueList.count < 10) {
                self.tableView.mj_footer.hidden = YES;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                self.tableView.mj_footer.hidden = NO;
                [self.tableView.mj_footer resetNoMoreData];
            }
            
        }else
        {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

//加载更多数据
- (void)loadMoreData
{
    pageNum++;
    params[@"pageNumber"] = @(pageNum);
    if (printerTaskListModel.totalPage >= pageNum) {
        [printerTaskListModel FetchTMXPrinterTaskListModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                printerTaskListModel = result;
                [self.dataSource addObjectsFromArray:printerTaskListModel.printQueueList];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
                
                if (printerTaskListModel.printQueueList.count < 10) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
            }
        }];
    }else
    {
        [self.tableView.mj_footer endRefreshing];
    }
    
}

- (void)loadCancelTaskData
{
    [cancelModel FetchTMXWaitPrinterCancelModel:canParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadNewData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//取消正在打印中的任务
- (void)loadCancelPrinterTaskData
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm_cancel", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Confirm", nil), nil];
    [UIView appearance].tintColor = systemColor;
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [cancelTaskModel FetchTMXCancelPrinterTaskModel:cancelParams callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:result];
                [self loadNewData];
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
    }
}

//开始打印任务
- (void)loadStartPrinterTaskData
{
    [startTaskModel FetchTMXStartPrinterTaskModel:startParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadNewData];
            TMXPrinteringVC *prineringVC = [[TMXPrinteringVC alloc] init];
            prineringVC.printerId = [NSString stringWithFormat:@"%ld", self.printerId];
            [self.navigationController pushViewController:prineringVC animated:YES];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//停止打印任务
- (void)loadStopPrinterTaskData
{
    [stopTaskModel FetchTMXStopPrinterTaskModel:stopParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadNewData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//打印任务存档
- (void)LoadPrintQueueArchiveData
{
    [printQueueArchiveModel FetchTMXPrintQueueArchiveModel:archiveParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadNewData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//复原存档任务
- (void)loadRestoreArchiveData
{
    [restoreArchiveModel FetchTMXRestoreQueueArchiveModel:restoreParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadNewData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark -- tableView delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (selectTag == 0) {
        if (segmentTag == 1) {
            if (self.dataSource.count) {
                return 100*AppScale;
            }
        }
    }
    return 0;
}

-(NSArray *)originalDataSource:(KBDragTableView *)tableView{
    return _dataSource;
}

-(void)tableView:(KBDragTableView *)tableView newDataSource:(NSArray *)dataSource{
    [_dataSource removeAllObjects];
    [_dataSource addObjectsFromArray:dataSource];
    [_tableView reloadData];
}

-(void)touchEndMoving:(KBDragTableView *)tableView fromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    
    TMXPrinterTaskListListModel *fromModel=[self.dataSource objectAtIndexCheck:fromIndexPath.row];
     TMXPrinterTaskListListModel *toModel=[self.dataSource objectAtIndexCheck:toIndexPath.row];
    updateOrderParams[@"id"] = @(fromModel.taskId);
    updateOrderParams[@"nextId"] = @(toModel.taskId);
    [updatePrinterOrderModel FetchTMXUpdatePrinterOrderModel:updateOrderParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TMXPrinterTaskCell * cell = [tableView dequeueReusableCellWithIdentifier:PrinterTaskListCellID];
    if (!cell) {
        cell = [[TMXPrinterTaskCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:PrinterTaskListCellID];
    }
    cell.selectTag = selectTag;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (selectTag == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.listModel=[self.dataSource objectAtIndexCheck:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXPrinterTaskCell * cell = (TMXPrinterTaskCell *)[tableView cellForRowAtIndexPath:indexPath];
    updataTaskStatusView = [[TMXPrinterTaskStatusView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    updataTaskStatusView.delegate = self;
    TMXPrinterTaskListListModel *listModel = self.dataSource[indexPath.row];
    if (selectTag == 0) {
        if (segmentTag == 1) {
            TMXPrinteringVC *prineringVC = [[TMXPrinteringVC alloc] init];
            prineringVC.printerId = [NSString stringWithFormat:@"%ld", self.printerId];
            [self.navigationController pushViewController:prineringVC animated:YES];
        }else if(segmentTag == 0)
        {
            NSArray *iconArray = @[@"StartPrinterIcon", @"TaskCancelIcon", @"TaskArhiveIcon"];
            NSArray *nameArray = @[NSLocalizedString(@"Start", nil), NSLocalizedString(@"Task_cancel", nil), NSLocalizedString(@"Task_archive", nil)];
            updataTaskStatusView.statusIcon = iconArray;
            updataTaskStatusView.statusName = nameArray;
            updataTaskStatusView.count = 3;
            updataTaskStatusView.printerTaskID = listModel.taskId;
            [[[UIApplication sharedApplication]keyWindow]addSubview:updataTaskStatusView];
        }else
        {
            NSArray *iconArray = @[@"StartPrinterIcon", @"TaskArhiveIcon"];
            NSArray *nameArray = @[NSLocalizedString(@"Start", nil), NSLocalizedString(@"Task_archive", nil)];
            updataTaskStatusView.statusIcon = iconArray;
            updataTaskStatusView.statusName = nameArray;
            updataTaskStatusView.count = 2;
            updataTaskStatusView.printerTaskID = listModel.taskId;
            [[[UIApplication sharedApplication]keyWindow]addSubview:updataTaskStatusView];
        }
    }else if(selectTag == 3)
    {
        cell.selected = !selectCell;
        selectCell = !selectCell;
        NSString *str = [NSString stringWithFormat:@"%ld", listModel.taskId];
        if (cell.selected) {
            [self.taskIDArray addObject:str];
        }else
        {
            [self.taskIDArray removeObject:str];
        }
        restoreParams[@"ids"] = (NSArray *)self.taskIDArray;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXPrinterTaskCell * cell = (TMXPrinterTaskCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (selectTag ==3) {
        cell.selected = selectCell;
        selectCell = !selectCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (selectTag == 0) {
        if (segmentTag == 1) {
            if (printerTaskListModel.printQueueList.count) {
                TMXPrinterTaskFooterView *footerView = [[TMXPrinterTaskFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*AppScale)];
                TMXPrinterTaskListListModel *listModel = self.dataSource[0];
                cancelParams[@"id"] = @(listModel.taskId);
                //取消打印任务
                footerView.cancelTaskBlock = ^(){
                    
                    [self loadCancelPrinterTaskData];
                };
                return footerView;
            }
        }
    }
    return nil;
}

//打印任务/存档任务
- (void)taskStatus:(UISegmentedControl *)sender
{
    selectTag = sender.selectedSegmentIndex;
    if (selectTag == 0) {
        params[@"status"] = @(segmentTag);
        [self.tableView.mj_header beginRefreshing];
        [printerTaskBar removeFromSuperview];
        isLoadFooterView = NO;
        [self loadFooter];
    }else if (selectTag == 1) {
        params[@"status"] = @(4);
        isLoadFooterView = YES;
        [self loadFooter];
        [self.tableView.mj_header beginRefreshing];
    }
    if (sender.selectedSegmentIndex == 0) {
        segmentView.hidden = NO;
        self.tableView.frame = CGRectMake(0, 64+50*AppScale, SCREENWIDTH, SCREENHEIGHT-64-50*AppScale);
        self.navigationItem.rightBarButtonItem = nil;
    }else
    {
        segmentView.hidden = YES;
        //设置导航栏
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalImage:@"ControllerCenterIcon_white" selectImage:@"ControllerCenterIcon_white" target:self action:@selector(restore)];
        self.tableView.frame = CGRectMake(0, 64+10*AppScale, SCREENWIDTH, SCREENHEIGHT-64-10*AppScale);
    }
}

//导航栏
- (void)restore
{
    isLoadFooterView = NO;
    [self loadFooter];
    if (self.dataSource.count) {
        selectTag = 3;
        self.tableView.tableFooterView = [UIView new];
        [self.view addSubview:printerTaskBar];
    }else
    {
        [printerTaskBar removeFromSuperview];
    }
    [self.tableView reloadData];
}


#pragma mark - KBSegmentViewDelegate
-(void)selectSegment:(NSInteger)index
{
    segmentTag = index;
    [printerTaskBar removeFromSuperview];
    params[@"status"] = @(index);
    [self.tableView.mj_header beginRefreshing];
    isLoadFooterView = NO;
    [self loadFooter];
}

#pragma mark - TMXPrinterTaskBarDelegate
-(void)clickTask:(NSInteger)tag
{
    if (tag == 1) {
        selectTag = 2;
        [self.tableView reloadData];
        isLoadFooterView = YES;
        [self loadFooter];
        [printerTaskBar removeFromSuperview];
    }else
    {
        
        if (self.taskIDArray.count == 0) {
            selectTag = 3;
            [MBProgressHUD showError:NSLocalizedString(@"Select_restore", nil)];
        }else
        {
            selectTag = 1;
            [self loadRestoreArchiveData];
            isLoadFooterView = YES;
            [self loadFooter];
            [printerTaskBar removeFromSuperview];
        }
    }
    
}

#pragma mark - TMXPrinterTaskStatusViewDelegate
-(void)clickTMXPrinterTaskStatusView:(NSString *)name printerTaskID:(NSInteger)printerTaskID
{
    if ([name isEqualToString:NSLocalizedString(@"Start", nil)]) {
        startParams[@"id"] = @(printerTaskID);
        [self loadStartPrinterTaskData];
        [updataTaskStatusView removeFromSuperview];
    }else if ([name isEqualToString:NSLocalizedString(@"Task_cancel", nil)])
    {
        stopParams[@"id"] = @(printerTaskID);
        [self loadStopPrinterTaskData];
        [updataTaskStatusView removeFromSuperview];
    }else if ([name isEqualToString:NSLocalizedString(@"Task_archive", nil)])
    {
        archiveParams[@"id"] = @(printerTaskID);
        [self LoadPrintQueueArchiveData];
        [updataTaskStatusView removeFromSuperview];
    }
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMXPrinterTaskListListModel *listModel = self.dataSource[indexPath.row];
    UITableViewRowAction *deleteAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:NSLocalizedString(@"Model_delete", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        canParams[@"id"] = @(listModel.taskId);
        [self loadCancelTaskData];
        //调用删除接口
    }];
    return @[deleteAction];
}

#pragma mark - setter getter
-(void)setPrinterId:(NSInteger)printerId
{
    _printerId = printerId;
}

#pragma mark - loadFooter
- (void)loadFooter
{
    if (isLoadFooterView) {
        TMXQueueArchiveFooterView *archiveView = [[TMXQueueArchiveFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80*AppScale)];
        self.tableView.tableFooterView = archiveView;
        
    }else
    {
        if (segmentTag == 0) {
            if (self.dataSource.count) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*AppScale)];
                view.backgroundColor = backGroundColor;
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10*AppScale, SCREENWIDTH, 25*AppScale)];
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10*AppScale);
                btn.backgroundColor = backGroundColor;
                btn.titleLabel.font = [UIFont systemFontOfSize:11*AppScale];
                [btn setImage:[UIImage imageNamed:@"icon_prompt"] forState:UIControlStateNormal];
                [btn setTitle:NSLocalizedString(@"Sort", nil) forState:UIControlStateNormal];
                [btn setTitleColor:RGBColor(162, 163, 164) forState:UIControlStateNormal];
                [view addSubview:btn];
                self.tableView.tableFooterView = view;
            }
        }else
        {
            self.tableView.tableFooterView = [[UIView alloc] init];
        }
        
    }
}

@end
