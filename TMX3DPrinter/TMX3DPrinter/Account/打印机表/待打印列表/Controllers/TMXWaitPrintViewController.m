//
//  TMXWaitPrintViewController.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXWaitPrintViewController.h"
#import "TMXWaitPrinterCell.h"
#import "TMXWaitPrinterModel.h"

@interface TMXWaitPrintViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    TMXWaitPrinterModel *waitPrinterModel;       ///<共享用户查看打印任务列表
    NSMutableDictionary *params;                ///<传入打印机ID
    
    TMXWaitPrinterCancelModel *cancelTaskModel; ///<取消打印任务
    NSMutableDictionary *cancelParams;          ///<传入任务ID
    
}

@property (nonatomic,strong)UITableView * tableView;

@end

@implementation TMXWaitPrintViewController
static NSString * const CellID = @"TMXWaitPrinterCell";

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = backGroundColor;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:NSLocalizedString(@"File_list", nil)];
    [self initUI];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

#pragma mark -- init UI
- (void)initUI{

    waitPrinterModel = [[TMXWaitPrinterModel alloc]init];
    params = [NSMutableDictionary dictionary];
    cancelTaskModel = [[TMXWaitPrinterCancelModel alloc] init];
    cancelParams = [NSMutableDictionary dictionary];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TMXWaitPrinterCell class] forCellReuseIdentifier:CellID];
}

#pragma mark - loadData
- (void)loadData
{
    params[@"printerId"] = @(self.printerId);
    [waitPrinterModel FetchTMXWaitPrinterModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            waitPrinterModel = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

- (void)loadCancelTaskData
{
    [cancelTaskModel FetchTMXWaitPrinterCancelModel:cancelParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark -- tableVeiw delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return waitPrinterModel.printQueueList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*AppScale)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10*AppScale, 0, SCREENWIDTH-20*AppScale, 40*AppScale)];
    NSString *com = NSLocalizedString(@"ComHave", nil);
    NSString *wait = NSLocalizedString(@"ModelWaitPrint", nil);
    title.text=[NSString stringWithFormat:@"%@%ld%@", com,waitPrinterModel.printQueueCount,wait];
    NSString *str = [NSString stringWithFormat:@"%ld", waitPrinterModel.printQueueCount];
    title.textColor = RGBColor(51, 51, 51);
    title.font = [UIFont systemFontOfSize:12*AppScale];
    [NSString labelString:title font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(com.length, str.length) color:systemColor];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39*AppScale, SCREENWIDTH, 1)];
    line.backgroundColor = RGBColor(200, 199, 204);
    [view addSubview:line];
    [view addSubview:title];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMXWaitPrinterCell *printerCell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!printerCell) {
        printerCell = [[TMXWaitPrinterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    printerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    TMXWaitPrinterListModel *listModel = [waitPrinterModel.printQueueList objectAtIndex:indexPath.row];
    printerCell.waitPriterListModel = waitPrinterModel.printQueueList[indexPath.row];
    if (listModel.belongToUser && listModel.status == 0) {
        printerCell.userInteractionEnabled=YES;
    }else{
         printerCell.userInteractionEnabled=NO;
    }
   
    return printerCell;
}

 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXWaitPrinterListModel *listModel = [waitPrinterModel.printQueueList objectAtIndex:indexPath.row];
    if (listModel.belongToUser) {
        UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                             title:NSLocalizedString(@"Cancel", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                                 
                                                                                 cancelParams[@"id"] = @(listModel.waitPrinterID);
                                                                                 [self loadCancelTaskData];
                                                                             }];
        
        rowAction.backgroundColor = systemColor;
        
        NSArray *array = @[rowAction];
        return array;
    }else{
        return nil;
    }
}

#pragma mark - setter getter
-(void)setPrinterId:(NSInteger)printerId
{
    _printerId = printerId;
}


@end
