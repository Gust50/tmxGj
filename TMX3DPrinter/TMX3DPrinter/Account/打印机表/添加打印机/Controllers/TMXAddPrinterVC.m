//
//  TMXAddPrinterVC.m
//  TMX3DPrinter
//
//  Created by kobe on 16/9/22.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXAddPrinterVC.h"
#import "TMXAddPrinterCell.h"
#import "TMXScanQRCodeModel.h"

@interface TMXAddPrinterVC ()<UITableViewDelegate,UITableViewDataSource,TMXAddPrinterCellDelegate>
{
    TMXScanQRCodeModel *scanQRCodeModel;            ///<扫描二维码
    MBProgressHUD *hud;
    
    TMXAddPrinterToPrinterListModel *addPrinterModel;    ///<共享打印机用户添加
    NSMutableDictionary *addParams;
    
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TMXAddPrinterVC
static NSString *const addPrinterID=@"addPrinterID";

#pragma mark <lazyLoad>
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 10*AppScale, SCREENWIDTH, SCREENHEIGHT-10*AppScale) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"Scan_result", nil)];
    self.view.backgroundColor = backGroundColor;
    self.tableView.backgroundColor = backGroundColor;
    scanQRCodeModel = [TMXScanQRCodeModel new];
    addPrinterModel = [TMXAddPrinterToPrinterListModel new];
    addParams = [NSMutableDictionary dictionary];
    
    [self.view addSubview:self.tableView];
    [_tableView registerClass:[TMXAddPrinterCell class] forCellReuseIdentifier:addPrinterID];
    [self loadData];
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor clearColor];
    hud.color=[UIColor clearColor];
    hud.activityIndicatorColor=systemColor;
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
    [scanQRCodeModel FetchTMXScanQRCodeModel:_requestParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            scanQRCodeModel = result;
            addParams[@"printerId"] = @(scanQRCodeModel.printerId);
            addParams[@"code"] = scanQRCodeModel.code;
            [self.tableView reloadData];
            [hud hide:YES];
        }else
        {
            hud.labelText=NSLocalizedString(@"Load_Fail", nil);
            [hud hide:YES afterDelay:2];
        }
    }];
}

- (void)loadAddPrinterData
{
    addParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    [addPrinterModel FetchTMXAddPrinterToPrinterListModel:addParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"Add_Suc", nil)];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMXAddPrinterCell *addPrinterCell=[tableView dequeueReusableCellWithIdentifier:addPrinterID forIndexPath:indexPath];
    addPrinterCell.selectionStyle = UITableViewCellSelectionStyleNone;
    addPrinterCell.delegate=self;
    addPrinterCell.model = scanQRCodeModel;
    return addPrinterCell;
}
#pragma mark <UITableViewDelegate>
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

#pragma mark <TMXAddPrinterCellDelegate>
-(void)addPrinter{
    [self loadAddPrinterData];
}

#pragma mark <getter setter>
-(void)setRequestParams:(NSDictionary *)requestParams{
    _requestParams=requestParams;
}
@end
