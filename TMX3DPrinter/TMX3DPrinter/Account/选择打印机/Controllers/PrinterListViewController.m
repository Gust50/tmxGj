//
//  PrinterListViewController.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "PrinterListViewController.h"
#import "PrinterHeadView.h"
#import "PrinterListTableViewCell.h"
#import "TMXPrinterListModel.h"

@interface PrinterListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    TMXPrinterListModel *printerListModel;      ///<打印机列表
    NSMutableDictionary *params;                ///<参数
    NSInteger printerID;                        ///<选择打印机ID
    NSString *printerName;                      ///<打印机名
}

@property (nonatomic,strong)UITableView * tableView;
@end

@implementation PrinterListViewController

static NSString * const headViewID = @"priterHeadID";
static NSString * const printerListCellID = @"printerListCellID";

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

#pragma mark - loadData
- (void)loadData
{
    params[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    [printerListModel FetchTMXPrinterListModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            printerListModel = result;
//            if (printerListModel.printerList.count || printerListModel.sharePrinterList.count) {
//                [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//            }
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark -- initUI
- (void)initUI{

    self.navigationItem.title = NSLocalizedString(@"SelectPrinter", nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGBColor(228, 234, 233);
    printerListModel = [[TMXPrinterListModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    [self.tableView registerClass:[PrinterHeadView class] forHeaderFooterViewReuseIdentifier:headViewID];
    [self.tableView registerClass:[PrinterListTableViewCell class] forCellReuseIdentifier:printerListCellID];
    [self.view addSubview:_tableView];
}

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

    return 60*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    PrinterListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:printerListCellID];
    if (!cell) {
        cell = [[PrinterListTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:printerListCellID];
    }
    cell.selected = YES;
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    PrinterHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headViewID];
    
    if (!headView) {
        headView = [[PrinterHeadView alloc] initWithReuseIdentifier:headViewID];
    }
    
    if (printerListModel.printerList.count && printerListModel.sharePrinterList.count) {
        if (section == 0) {
            
            headView.headLabel.text = NSLocalizedString(@"Binding_printer", nil);
            
        }else{
            
            headView.headLabel.text = NSLocalizedString(@"Share_printer", nil);
        }
    }else if (printerListModel.printerList.count && !printerListModel.sharePrinterList.count)
    {
        headView.headLabel.text = NSLocalizedString(@"Binding_printer", nil);
        
    }else if (!printerListModel.printerList.count && printerListModel.sharePrinterList.count)
    {
        headView.headLabel.text = NSLocalizedString(@"Share_printer", nil);
    }
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrinterListTableViewCell * cell = (PrinterListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    NSMutableDictionary *printerParams = [NSMutableDictionary dictionary];
    if (printerListModel.printerList.count && printerListModel.sharePrinterList.count) {
        if (indexPath.section == 0) {
            TMXPrinterListListModel *listModel = printerListModel.printerList[indexPath.row];
            printerID = listModel.printerListID;
            if (listModel.printerName.length) {
                printerName = listModel.printerName;
            }else
            {
                printerName = [NSString stringWithFormat:@"#%ld", listModel.printerListID];
            }
            
        }else{
            TMXPrinterListShareListModel *shareListModel = printerListModel.sharePrinterList[indexPath.row];
            printerID = shareListModel.printerId;
            if (shareListModel.printerName.length) {
                printerName = shareListModel.printerName;
            }else
            {
                printerName = [NSString stringWithFormat:@"#%ld", shareListModel.printerId];
            }
        }
    }else if (printerListModel.printerList.count && !printerListModel.sharePrinterList.count)
    {
        TMXPrinterListListModel *listModel = printerListModel.printerList[indexPath.row];
       printerID = listModel.printerListID;
        if (listModel.printerName.length) {
            printerName = listModel.printerName;
        }else
        {
            printerName = [NSString stringWithFormat:@"#%ld", listModel.printerListID];
        }
        
    }else if (!printerListModel.printerList.count && printerListModel.sharePrinterList.count)
    {
        TMXPrinterListShareListModel *shareListModel = printerListModel.sharePrinterList[indexPath.row];
        printerID = shareListModel.printerId;
        if (shareListModel.printerName.length) {
            printerName = shareListModel.printerName;
        }else
        {
            printerName = [NSString stringWithFormat:@"#%ld", shareListModel.printerId];
        }
    }
    
    printerParams[@"printerId"] = @(printerID);
    printerParams[@"printerName"] = printerName;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectPrinterID" object:nil userInfo:printerParams];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrinterListTableViewCell * cell = (PrinterListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

@end
